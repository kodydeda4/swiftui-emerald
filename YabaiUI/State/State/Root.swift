//
//  Root.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/7/21.
//

import SwiftUI
import ComposableArchitecture

struct Root {
    struct State: Equatable {
        var dataManager = DataManager.State()
        var onboarding = Onboarding.State()
    }
    
    enum Action: Equatable {
        case dataManager(DataManager.Action)
        case onboarding(Onboarding.Action)
        
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Void>.combine(
        DataManager.reducer.pullback(
            state: \.dataManager,
            action: /Root.Action.dataManager,
            environment: { _ in .init() }
        ),
        Onboarding.reducer.pullback(
            state: \.onboarding,
            action: /Root.Action.onboarding,
            environment: { _ in () }
        )
    )
}

extension Root {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}

