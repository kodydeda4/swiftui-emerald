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
        var version = run("/usr/local/bin/skhd", "-v").stdout
        var error: DataManagerError  = .none
        var dataManager = DataManager<SKHDSettings.State>(
            stateFilename: "SKHDState.json",
            configFilename: "skhdrc"
        )
    }
    enum Action: Equatable {
        case skhdSettings(SKHDSettings.Action)
        case saveState
        case loadState
        case exportConfig
    }
}

extension SKHD {
    static let reducer = Reducer<State, Action, Void>.combine(
        SKHDSettings.reducer.pullback(
            state: \.skhdSettings,
            action: /Action.skhdSettings,
            environment: { _ in () }
        ),

        Reducer { state, action, environment in
            switch action {
            
            case let .skhdSettings(subAction):
                return Effect(value: .saveState)
                    
            case .saveState:
                switch state.dataManager.encodeState(state.skhdSettings) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .encodeState
                }
                return .none
                
            case .loadState:
                switch state.dataManager.decodeState(state.skhdSettings) {
                case let .success(decoded):
                    state.skhdSettings = decoded
                case let .failure(error):
                    state.error = .decodeState
                }
                return .none
                
            case .exportConfig:
                switch state.dataManager.exportConfig(state.skhdSettings.asConfig) {
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

extension SKHD {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}
