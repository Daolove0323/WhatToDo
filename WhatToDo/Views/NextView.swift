//
//  NextView.swift
//  WhatToDo
//
//  Created by 조홍식 on 2022/08/23.
//

import SwiftUI

struct NextView: View {
    @EnvironmentObject var localNotificationManager: LocalNotificationManager
    
    var body: some View {
            VStack {
                List{
                    Text("\(localNotificationManager.notifications.count)")
                }
                
            }
        
    }
}

//
//struct NextView_Previews: PreviewProvider {
//    static var previews: some View {
//    }
//}
