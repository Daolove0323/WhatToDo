//
//  Store.swift
//  WhatToDo
//
//  Created by 조홍식 on 2022/09/02.
//

import Foundation

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    private let reducer: Reducer<State, Action>
    
    init(state: State, reducer: @escaping Reducer<State, Action>) {
        self.state = state
        self.reducer = reducer
    }
    
    func dispatch(action: Action) {
        reducer(&self.state, action)
    }
}
