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
        var settings = Settings.State()
        var onboarding = Onboarding.State()
        var configManager = ConfigManager.State()
    }
    
    enum Action: Equatable {
        case settings(Settings.Action)
        case onboarding(Onboarding.Action)
        case configManager(ConfigManager.Action)
    }
    
    struct Environment {

    }
}

extension Root {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Settings.reducer.pullback(
            state: \.settings,
            action: /Root.Action.settings,
            environment: { _ in .init() }
        ),
        Onboarding.reducer.pullback(
            state: \.onboarding,
            action: /Root.Action.onboarding,
            environment: { _ in () }
        ),
        ConfigManager.reducer.pullback(
            state: \.configManager,
            action: /Root.Action.configManager,
            environment: { _ in .init() }
        ),
        Reducer { state, action, environment in
            switch action {
                        
            case let .settings(subAction):
                return .none

            case let .onboarding(subAction):
                return .none
                
            case let .configManager(subAction):
                return .none
                                
            }
        }
    )
}

extension Root {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}
