//
//  Reducer.swift
//  WhatToDo
//
//  Created by 조홍식 on 2022/09/02.
//

import Foundation

typealias Reducer<State, Action> = (inout State, Action) -> Void

func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    case .rollthedice:
        print("ex")
    }
}
