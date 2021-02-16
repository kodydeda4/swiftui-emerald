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
        var configFiles = ConfigFiles.State()
        var onboarding = Onboarding.State()
    }
    
    enum Action: Equatable {
        case settings(Settings.Action)
        case onboarding(Onboarding.Action)
        case configManager(ConfigFiles.Action)
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Void>.combine(
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
        ConfigFiles.reducer.pullback(
            state: \.configFiles,
            action: /Root.Action.configManager,
            environment: { _ in .init() }
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
