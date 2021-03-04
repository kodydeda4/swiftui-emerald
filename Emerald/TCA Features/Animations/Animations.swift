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
        
        func encodeSettings(_ state: AnimationSettings.State) -> Result<Bool, Error> {
            do {
                try JSONEncoder()
                    .encode(state)
                    .write(to: stateURL)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func decodeSettings(_ state: AnimationSettings.State) -> Result<(AnimationSettings.State), Error> {
            do {
                let decoded = try JSONDecoder()
                    .decode(AnimationSettings.State.self, from: Data(contentsOf: stateURL))
                return .success(decoded)
            }
            catch {
                return .failure(error)
            }
        }
        func exportConfig(_ animationSettingsState: AnimationSettings.State) -> Result<Bool, Error> {
            do {
                let data: String = animationSettingsState.asConfig
                try data.write(to: configURL, atomically: true, encoding: .utf8)
                
                return .success(true)
            }
            catch {
                return .failure(error)
            }
        }
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
                switch environment.encodeSettings(state.animationSettings) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .saveSettings
                }
                return .none
                
            case .loadSettings:
                switch environment.decodeSettings(state.animationSettings) {
                case let .success(decoded):
                    state.animationSettings = decoded
                case let .failure(error):
                    state.error = .loadSettings
                }
                return .none
                
            case .exportConfig:
                switch environment.exportConfig(state.animationSettings) {
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
