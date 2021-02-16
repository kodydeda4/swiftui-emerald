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
        var configFileManager = ConfigFileManager.State()
        var onboarding = Onboarding.State()
    }
    
    enum Action: Equatable {
        case settings(Settings.Action)
        case onboarding(Onboarding.Action)
        case configManager(ConfigFileManager.Action)
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Void>.combine(
        Settings.reducer.pullback(
            state: \.settings,
            action: /Root.Action.settings,
            environment: { _ in .init() }
        ),
        ConfigFileManager.reducer.pullback(
            state: \.configFileManager,
            action: /Root.Action.configManager,
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
