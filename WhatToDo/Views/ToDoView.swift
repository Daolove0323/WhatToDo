//
//  ToDoView.swift
//  WhatToDo
//
//  Created by 조홍식 on 2022/08/23.
//

import SwiftUI


    
struct ToDoView: View {
    @EnvironmentObject var realmManager: RealmManager
    @EnvironmentObject var localNotificationManager: LocalNotificationManager
    
    var body: some View {
        List {
            ForEach(realmManager.tasks, id: \.id) { task in
                if !task.isInvalidated {
                    ToDoRow(task.task, task.isThereDeadline, task.deadline, task.notification, task.isCompleted)
                        .listRowBackground(Color.spaceCadet)
                        .listRowInsets(.init(.init(top: 5, leading: 40, bottom: 5, trailing: 10)))
                        .listRowSeparator(.hidden)
                    
                        .onTapGesture {
                            realmManager.updateTask(id: task.id, isCompleted: !task.isCompleted)
                        }

                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                realmManager.deleteTask(localNotificationManager: localNotificationManager, id: task.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
        }
        .listStyle(.plain)
    
    }
}
