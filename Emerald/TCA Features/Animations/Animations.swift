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
        var encoder       = DataManager<AnimationSettings.State>(
            stateURLFilename: "AnimationState.json",
            configURLFilename: ".animationSettingsRC.sh"
        )
        
        var error: Error = .none
        enum Error {
            case saveSettings
            case loadSettings
            case exportConfig
            case none
        }
    }
    
    enum Action: Equatable {
        case animationSettings(AnimationSettings.Action)
        case saveSettings
        case loadSettings
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
                return Effect(value: .saveSettings)
                    
            case .saveSettings:
                switch state.encoder.genericEncodeState(
                    state.animationSettings
                ) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .saveSettings
                }
                return .none
                
            case .loadSettings:
                switch state.encoder.genericDecodeSettings(state.animationSettings) {
                case let .success(decoded):
                    state.animationSettings = decoded
                case let .failure(error):
                    state.error = .loadSettings
                }
                return .none
                
            case .exportConfig:
                switch state.encoder.genericExportConfig(state.animationSettings.asConfig) {
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
