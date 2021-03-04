//
//  Yabai.swift
//  Emerald
//
//  Created by Kody Deda on 3/3/21.
//

import SwiftUI
import ComposableArchitecture
import SwiftShell

// Saves, Loads, & Exports Yabai Settings.

struct Yabai {
    struct State: Equatable {
        var yabaiSettings = YabaiSettings.State()
        var version       = run("/usr/local/bin/yabai", "-v").stdout
        var error: Error  = .none
        
        enum Error {
            case saveSettings
            case loadSettings
            case exportConfig
            case none
        }
    }
    
    enum Action: Equatable {
        case yabaiSettings(YabaiSettings.Action)
        case saveSettings
        case loadSettings
        case resetSettings
        case exportConfig
    }
    
    struct Environment {
        let stateURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("YabaiState.json")
        
        let configURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent(".yabairc")
        
        func encodeSettings(_ state: YabaiSettings.State) -> Result<Bool, Error> {
            do {
                try JSONEncoder()
                    .encode(state)
                    .write(to: stateURL)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func decodeSettings(_ state: YabaiSettings.State) -> Result<(YabaiSettings.State), Error> {
            do {
                let decoded = try JSONDecoder()
                    .decode(YabaiSettings.State.self, from: Data(contentsOf: stateURL))
                return .success(decoded)
            }
            catch {
                return .failure(error)
            }
        }
        func exportConfig(_ yabaiSettingsState: YabaiSettings.State) -> Result<Bool, Error> {
            do {
                let data: String = yabaiSettingsState.asConfig
                try data.write(to: configURL, atomically: true, encoding: .utf8)
                
                return .success(true)
            }
            catch {
                return .failure(error)
            }
        }
    }
}

extension Yabai {
    static let reducer = Reducer<State, Action, Environment>.combine(
        YabaiSettings.reducer.pullback(
            state: \.yabaiSettings,
            action: /Action.yabaiSettings,
            environment: { _ in () }
        ),
        Reducer { state, action, environment in
            switch action {
            
            case let .yabaiSettings(subAction):
                return Effect(value: .saveSettings)
                
            case .saveSettings:
                switch environment.encodeSettings(state.yabaiSettings) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .saveSettings
                }
                return .none
                
            case .loadSettings:
                switch environment.decodeSettings(state.yabaiSettings) {
                case let .success(decoded):
                    state.yabaiSettings = decoded
                case let .failure(error):
                    state.error = .loadSettings
                }
                return .none
                
            case .resetSettings:
                state.yabaiSettings = YabaiSettings.State()
                return .none
                
            case .exportConfig:
                switch environment.exportConfig(state.yabaiSettings) {
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

extension Yabai {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}
