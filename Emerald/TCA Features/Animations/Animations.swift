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
        var encoder           = DataManager<AnimationSettings.State>()
        var error: Error      = .none
        
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
    
    struct Environment {
        let stateURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("AnimationState.json")
        
        let configURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent(".animationSettingsRC.sh")
    }
}

extension Animations {
    static let reducer = Reducer<State, Action, Environment>.combine(
        AnimationSettings.reducer.pullback(
            state: \.animationSettings,
            action: /Action.animationSettings,
            environment: { _ in () }
        ),
        Reducer { state, action, environment in
            switch action {
            case let .animationSettings(subAction):
                return Effect(value: .saveSettings)
                    
            case .saveSettings:
                switch state.encoder.genericEncodeState(
                    state.animationSettings,
                    url: environment.stateURL
                ) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .saveSettings
                }
                return .none
                
            case .loadSettings:
                switch state.encoder.genericDecodeSettings(
                    state.animationSettings,
                    url: environment.stateURL
                ) {
                case let .success(decoded):
                    state.animationSettings = decoded
                case let .failure(error):
                    state.error = .loadSettings
                }
                return .none
                
            case .exportConfig:
                switch state.encoder.genericExportConfig(
                    state.animationSettings.asConfig,
                    url: environment.configURL
                ) {
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
        environment: .init()
    )
}
