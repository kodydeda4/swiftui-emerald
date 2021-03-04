//
//  DataManager.swift
//  Emerald
//
//  Created by Kody Deda on 2/17/21.
//

import ComposableArchitecture
import SwiftShell

struct Animations {
    struct State: Equatable {
        var animationSettings = AnimationSettings.State()
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
        case loadConfig
    }
    
    struct Environment {
        let animationStateURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("AnimationState.json")
        
        let animationURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent(".animationSettingsRC.sh")
        
        func encodeAnimationSettings(_ state: AnimationSettings.State) -> Result<Bool, Error> {
            do {
                try JSONEncoder()
                    .encode(state)
                    .write(to: animationStateURL)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func decodeAnimationSettings(_ state: AnimationSettings.State) -> Result<(AnimationSettings.State), Error> {
            do {
                let decoded = try JSONDecoder()
                    .decode(AnimationSettings.State.self, from: Data(contentsOf: animationStateURL))
                return .success(decoded)
            }
            catch {
                return .failure(error)
            }
        }
        func exportAnimationConfig(_ animationSettingsState: AnimationSettings.State) -> Result<Bool, Error> {
            do {
                let data: String = animationSettingsState.asConfig
                try data.write(to: animationURL, atomically: true, encoding: .utf8)
                
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
            action: /Animations.Action.animationSettings,
            environment: { _ in () }
        ),
        Reducer { state, action, environment in
            switch action {
            case let .animationSettings(subAction):
                return Effect(value: .saveSettings)
                    
            case .saveSettings:
                switch environment.encodeAnimationSettings(state.animationSettings) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .saveSettings
                }
                return .none
                
            case .loadSettings:
                switch environment.decodeAnimationSettings(state.animationSettings) {
                case let .success(decoded):
                    state.animationSettings = decoded
                case let .failure(error):
                    state.error = .loadSettings
                }
                return .none
                
            case .loadConfig:
                switch environment.exportAnimationConfig(state.animationSettings) {
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
