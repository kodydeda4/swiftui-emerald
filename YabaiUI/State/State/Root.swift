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
        var yabaiConfiguration = YabaiConfiguration.State()
        var configFiles = ConfigFileManager.State()
        var onboarding = Onboarding.State()
    }
    
    enum Action: Equatable {
        case yabaiConfiguration(YabaiConfiguration.Action)
        case onboarding(Onboarding.Action)
        case configManager(ConfigFileManager.Action)
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Void>.combine(
        YabaiConfiguration.reducer.pullback(
            state: \.yabaiConfiguration,
            action: /Root.Action.yabaiConfiguration,
            environment: { _ in .init() }
        ),
        Onboarding.reducer.pullback(
            state: \.onboarding,
            action: /Root.Action.onboarding,
            environment: { _ in () }
        ),
        ConfigFileManager.reducer.pullback(
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
