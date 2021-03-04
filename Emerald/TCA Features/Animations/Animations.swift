//
//  Animations.swift
//  Emerald
//
//  Created by Kody Deda on 2/17/21.
//

import SwiftUI
import ComposableArchitecture
import SwiftShell

// Saves, Loads, & Exports Animation Settings.

struct Animations {
    struct State: Equatable {
        var animationSettings = AnimationSettings.State()
        var error: DataManagerError = .none
        var dataManager = DataManager<AnimationSettings.State>(
            stateFilename: "AnimationState.json",
            configFilename: ".animationSettingsRC.sh"
        )
    }
    enum Action: Equatable {
        case animationSettings(AnimationSettings.Action)
        case saveState
        case loadState
        case exportConfig
    }
}

extension Animations {
    static let reducer = Reducer<State, Action, Void>.combine(
        AnimationSettings.reducer.pullback(
            state: \.animationSettings,
            action: /Action.animationSettings,
            environment: { _ in () }
        ),
        Reducer { state, action, _ in
            switch action {
            case let .animationSettings(subAction):
                return Effect(value: .saveState)
                    
            case .saveState:
                switch state.dataManager.encodeState(state.animationSettings) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .encodeState
                }
                return .none
                
            case .loadState:
                switch state.dataManager.decodeState(state.animationSettings) {
                case let .success(decoded):
                    state.animationSettings = decoded
                case let .failure(error):
                    state.error = .decodeState
                }
                return .none
                
            case .exportConfig:
                switch state.dataManager.exportConfig(state.animationSettings.asConfig) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .exportConfig
                }
                return .none
                
            }
        }
    )
}

extension Animations {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}
