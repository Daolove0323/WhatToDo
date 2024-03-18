//
//  Task.swift
//  WhatToDo
//
//  Created by 조홍식 on 2022/08/23.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: ObjectId
//    @Persisted var title: String = ""
//    @Persisted var memo: String = ""
//    @Persisted var isCompleted: Bool = false
//    @Persisted var deadline: Date
//    @Persisted var notification: Bool = false
    @Persisted var task: String = ""
    @Persisted var isThereDeadline: Bool = false
    @Persisted var deadline: Date
    @Persisted var notification: Bool = false
    @Persisted var isCompleted: Bool  = false
}
