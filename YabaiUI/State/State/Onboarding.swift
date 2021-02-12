//
//  Onboarding.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

//MARK:- Onboarding

struct Onboarding {
    struct State: Equatable {
        var isDismissed = false
    }
    
    enum Action: Equatable {
        case toggleDismissed
    }
    
    struct Environment {
        // environment
    }
}

extension Onboarding {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Reducer { state, action, environment in
            switch action {
            
            case .toggleDismissed:
                state.isDismissed.toggle()
                return .none
                
            }
        }
    )
}

extension Onboarding {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}


