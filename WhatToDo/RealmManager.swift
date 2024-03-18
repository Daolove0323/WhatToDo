//
//  RealmManager.swift
//  WhatToDo
//
//  Created by 조홍식 on 2022/08/23.
//

import SwiftUI
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published private(set) var tasks: [Task] = []
    
        init() {
            openRealm()
            getTasks()
        }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL!)

        } catch {
            print("error1")
        }
    }
    
    func addTask(localNotificationManager: LocalNotificationManager, task: String, isThereDeadline: Bool, deadline: Date, notification: Bool) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Task(value: ["task": task, "isThereDeadline": isThereDeadline, "deadline": deadline, "notification": notification, "isCompleted": false])
                    localRealm.add(newTask)
                    if notification {
                        localNotificationManager.setNotification(newTask.id, newTask.task, newTask.deadline)
                    }
                    
                    getTasks()
                    print("added new task")
                }
            } catch {
                print("error2")
            }
        }
    }
    
    func getTasks() {
        if let localRealm = localRealm {
            let allTasks = localRealm.objects(Task.self).sorted{$0.deadline < $1.deadline}
            tasks = []
            allTasks.forEach { task in
                tasks.append(task)
            }
        }
    }
    
    func updateTask(id: ObjectId, isCompleted: Bool) {
        if let localRealm = localRealm {
            do {
                let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToUpdate.isEmpty else {return}
                
                try localRealm.write() {
                    taskToUpdate[0].isCompleted = isCompleted
                    getTasks()
                    print("Updated task with id \(id) Completed status: \(isCompleted)")
                }
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    
    func deleteTask(localNotificationManager: LocalNotificationManager, id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToDelete.isEmpty else {return}
                
                try localRealm.write {
                    localRealm.delete(taskToDelete)
                    
                        localNotificationManager.removeNotification(id)
                    
                    getTasks()
                    
                    print("Deleted task with id \(id)")
                }
            } catch {
                print("Error deleting task \(id) from Realm: \(error)")
            }
        }
    }
    
    
}
