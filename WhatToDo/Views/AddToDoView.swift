//
//  AddToDoView.swift
//  WhatToDo
//
//  Created by 조홍식 on 2022/08/23.
//

import SwiftUI
import Combine

struct AddToDoView: View {
    
    @Binding var isAddButtonClicked: Bool
    @State private var newTask: String = ""
    @State private var newDeadline: Date = Date()
    @EnvironmentObject var realmManager: RealmManager
    @State private var keyboardHeight: CGFloat = 0
    @State private var dateOn = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            
            Toggle(isOn: $dateOn, label: {
                Text("Date")
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                //                            .font(Font.custom("EF_Diary", size: 20))
                    .foregroundColor(Color.mauve)
                    .padding(.horizontal, 5)
            })
            .toggleStyle(SwitchToggleStyle(tint: Color.spaceCadet))
            .padding()
            
            if dateOn {
                DatePicker("", selection: $newDeadline, in: Date()...)
                    .datePickerStyle(.compact)
                    .labelsHidden()
            }
            
            TextField("  Add a task", text: $newTask)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 15)
                .disableAutocorrection(true)
            
            Button(action: {
//                realmManager.addTask(toDo: newTask, deadline: newDeadline)
                hideKeyboard()
                isAddButtonClicked = false
                
            }, label: {
                Text("Submit")
                    .font(.title3)
                    .frame(width: 120, height: 50)
                    .background(Color.midiumPurple)
                    .cornerRadius(20)
                    .padding()
                    .foregroundColor(Color.spaceCadet)
            })
        }
    }
}
