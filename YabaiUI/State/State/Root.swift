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
        var settingsManager = SettingsManager.State()
        var configManager = ConfigManager.State()
        var onboarding = Onboarding.State()
    }
    
    enum Action: Equatable {
        case settingsManager(SettingsManager.Action)
        case onboarding(Onboarding.Action)
        case configManager(ConfigManager.Action)
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Void>.combine(
        SettingsManager.reducer.pullback(
            state: \.settingsManager,
            action: /Root.Action.settingsManager,
            environment: { _ in .init() }
        ),
        ConfigManager.reducer.pullback(
            state: \.configManager,
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

