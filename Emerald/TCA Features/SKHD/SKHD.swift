//
//  SKHD.swift
//  Emerald
//
//  Created by Kody Deda on 3/3/21.
//

import SwiftUI
import ComposableArchitecture
import SwiftShell

// Saves, Loads, & Exports SKHD Settings.

struct SKHD {
    struct State: Equatable {
        var skhdSettings = SKHDSettings.State()
        var encoder       = DataManager<SKHDSettings.State>()
        var version      = run("/usr/local/bin/skhd", "-v").stdout
        var error: Error = .none
        
        enum Error {
            case saveSKHDSettings
            case loadSKHDSettings
            case exportSKHDConfig
            case none
        }
    }
    
    enum Action: Equatable {
        case skhdSettings(SKHDSettings.Action)
        case saveSettings
        case loadSettings
        case exportConfig
    }
    
    struct Environment {
        let stateURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("SKHDState.json")
        
        let configURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("skhdrc")
    }
}

extension SKHD {
    static let reducer = Reducer<State, Action, Environment>.combine(
        SKHDSettings.reducer.pullback(
            state: \.skhdSettings,
            action: /Action.skhdSettings,
            environment: { _ in () }
        ),

        Reducer { state, action, environment in
            switch action {
            
            case let .skhdSettings(subAction):
                return Effect(value: .saveSettings)
                    
            case .saveSettings:
                switch state.encoder.genericEncodeState(state.skhdSettings, url: environment.stateURL) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .saveSKHDSettings
                }
                return .none
                
            case .loadSettings:
                switch state.encoder.genericDecodeSettings(state.skhdSettings, url: environment.stateURL) {
                case let .success(decoded):
                    state.skhdSettings = decoded
                case let .failure(error):
                    state.error = .loadSKHDSettings
                }
                return .none
                
            case .exportConfig:
                switch state.encoder.genericExportConfig(state.skhdSettings.asConfig, url: environment.configURL) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .exportSKHDConfig
                }
                return .none            
            }
        }
    )
}

extension SKHD {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}
