//
//  ContentView.swift
//  WhatToDo
//
//  Created by 조홍식 on 2022/08/22.
//

import SwiftUI
import ExytePopupView

struct ContentView: View {
    @StateObject var realmManager = RealmManager()
    @StateObject var localNotificationManager = LocalNotificationManager()
    
    init() {
       UIScrollView.appearance().bounces = false
    }
    
    @State var newTask = ""
    @StateObject private var keyboardHandler = KeyboardHandler()

    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack (alignment: .bottomTrailing) {
                    VStack(spacing: 0) {
                        Spacer().frame(height: 100)
                        
                        ToDoView()
                            .environmentObject(realmManager)
                            .environmentObject(localNotificationManager)
                        
                        TextBox()
                            .environmentObject(realmManager)
                            .environmentObject(localNotificationManager)

                        
                            .padding(.bottom, keyboardHandler.keyboardHeight)
                            .animation(.easeInOut, value: keyboardHandler.keyboardHeight)
                        
                    }
                }
                
                .ignoresSafeArea(.all, edges: .all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.spaceCadet)
                .navigationBarItems(leading: NavigationLink(destination: NextView()                            .environmentObject(localNotificationManager)){
                    Image(systemName: "line.3.horizontal").font(.system(size: 25))
                        .foregroundColor(Color.mauve)
                }, trailing: Menu(content: {
                    Button("first", action: {})
                    Button("second", action: {})
                    Button("third", action: {})
                }, label: {
                    Image(systemName: "ellipsis").font(.headline)
                        .rotationEffect(.degrees(-90))
                        .foregroundColor(Color.mauve)
                })
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
