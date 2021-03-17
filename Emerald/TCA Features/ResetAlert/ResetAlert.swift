//
//  ResetAlert.swift
//  Emerald
//
//  Created by Kody Deda on 3/17/21.
//

import SwiftUI
import ComposableArchitecture

struct ResetAlert {
    struct State: Equatable {
        var isActive = false
    }
    enum Action: Equatable {
        case toggleIsActive
    }
}

extension ResetAlert {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        
        case .toggleIsActive:
            state.isActive.toggle()
            return .none
            
        }
    }
}

extension ResetAlert {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}
