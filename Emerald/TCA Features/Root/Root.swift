//
//  Root.swift
//  Emerald
//
//  Created by Kody Deda on 2/7/21.
//

import ComposableArchitecture
import SwiftShell

struct Root {
    struct State: Equatable {
        var dataManager   = DataManager.State()
        var onboarding    = Onboarding.State()

        var yabaiVersion : String = run("/usr/local/bin/yabai", "-v").stdout
        var skhdVersion  : String = run("/usr/local/bin/skhd", "-v").stdout
        var brewVersion  : String = run("/usr/local/bin/brew", "-v").stdout
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
        ),
        Reducer { state, action, environment in
            switch action {
            case .dataManager(_):
                return .none
            case .onboarding(_):
                return .none
            }
        }        
    )
}

extension Root {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}
