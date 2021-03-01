//
//  Onboarding.swift
//  Emerald
//
//  Created by Kody Deda on 2/11/21.
//

import ComposableArchitecture

struct Onboarding {
    struct State: Equatable {
        var isOnboaring = false
    }
    
    enum Action: Equatable {
        case toggleIsOnboaring
    }
}

extension Onboarding {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        
        case .toggleIsOnboaring:
            state.isOnboaring.toggle()
            return .none
            
        }
    }
}

extension Onboarding {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}
