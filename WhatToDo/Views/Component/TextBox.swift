//
//  TextBox.swift
//  WhatToDo
//
//  Created by 조홍식 on 2022/09/02.
//

import SwiftUI
import Combine
import RealmSwift

private func endEditing() {
    UIApplication.shared.endEditing()
}

enum SelectDateButton: String {
    case none, today, tommorow, direct
}

struct TextBox: View {
    
    
    @EnvironmentObject var realmManager: RealmManager
    @EnvironmentObject var localNotificationManager: LocalNotificationManager

    @State private var newTask = ""
    @State private var dateOn = false
    @State private var deadline: Date = Date()
    @State private var notification = false
    
    @State var selectedButton: SelectDateButton = .none
    @EnvironmentObject var realManager: RealmManager
    @State private var keyboardHeight: CGFloat = 0
    
    @FocusState private var focusedField: Bool?
    
    var body: some View {
        VStack(spacing: 0) {
            if selectedButton == .direct && newTask != ""{
                DatePicker("", selection: $deadline, in: Date()...)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .focused($focusedField, equals: true)
            }
            
            if focusedField == true || newTask != "" {
                HStack(spacing: 0) {
                    Button {
                        if selectedButton != .today {
                            selectedButton = .today
                        } else {
                            selectedButton = .none
                        }
                        
                        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
                        dateComponents.hour = 23
                        dateComponents.minute = 59
                        let calendar = Calendar.current
                        deadline = calendar.date(from: dateComponents)!
                        
                    } label: {
                        Text("오늘")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(selectedButton == .today ? Color.midiumPurple : Color.spaceCadet)
                            .cornerRadius(16)
                            .padding(.leading, 10)
                    }
                    
                    Button {
                        if selectedButton != .tommorow {
                            selectedButton = .tommorow
                        } else {
                            selectedButton = .none
                        }
                        
                        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
                        dateComponents.day! += 1
                        dateComponents.hour = 23
                        dateComponents.minute = 59
                        let calendar = Calendar.current
                        deadline = calendar.date(from: dateComponents)!
                        
                        
                    } label: {
                        Text("내일")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(selectedButton == .tommorow ? Color.midiumPurple : Color.spaceCadet)
                            .cornerRadius(16)
                            .padding(.leading, 8)
                    }
                    
                    Button {
                        if selectedButton != .direct {
                            selectedButton = .direct
                        } else {
                            selectedButton = .none
                        }
                    } label: {
                        Circle().frame(width: 40, height: 40)
                            .foregroundColor(selectedButton == .direct ? .midiumPurple : .spaceCadet)
                            .overlay {
                                Image(systemName: "calendar")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            }
                            .padding(.leading, 8)
                    }
                    
                    Spacer().frame(width: 10)
                    
                    Button {
                        notification.toggle()
                    } label: {
                        Circle().frame(width: 40, height: 40)
                            .foregroundColor(notification ? .midiumPurple : .spaceCadet)
                            .overlay {
                                Image(systemName: notification ? "bell.fill" : "bell.slash.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            }
                            .padding(.leading, 8)
                        
                    }
                    Spacer()
                }
                .frame(height: 50)

            }
            
            HStack(spacing: 0) {
                TextField("", text: $newTask)
                    .placeholder(when: newTask.isEmpty) {
                        Text("  Add a task").foregroundColor(.white)
                    }
                    .disableAutocorrection(true)
                    .focused($focusedField, equals: true)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 18).fill(Color.mauve))
                    .padding(.trailing, 2)
                
                
                Button {
                    if newTask != "" {
                        realmManager.addTask(localNotificationManager: localNotificationManager, task: newTask, isThereDeadline:  !(selectedButton == .none), deadline: deadline, notification: notification)
                        hideKeyboard()
                        newTask = ""
                        selectedButton = .none
                        notification = false
                        deadline = Date()
                    }
                } label: {
                    Circle().frame(width: 40, height: 40)
                        .foregroundColor(.purpleNavy)
                        .overlay {
                            Image(systemName: "arrow.up")
                                .foregroundColor(.white)
                        }
                }
            }
            .padding(.horizontal, 3)
        }
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 5
        }
        .padding(.bottom, 7)
    }
}

struct TextBox_Previews: PreviewProvider {
    static var previews: some View {
        TextBox()
            .environmentObject(RealmManager())
        
    }
}
