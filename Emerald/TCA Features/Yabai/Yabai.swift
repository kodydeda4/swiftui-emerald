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
        var encoder       = DataManager<YabaiSettings.State>()
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
                switch state.encoder.genericEncodeState(
                    state.yabaiSettings,
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
                    state.yabaiSettings,
                    url: environment.stateURL
                ) {
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
                switch state.encoder.genericExportConfig(
                    state.yabaiSettings.asConfig,
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

extension Yabai {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}
