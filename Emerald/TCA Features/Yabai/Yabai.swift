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
        var version = run("/usr/local/bin/yabai", "-v").stdout
        var error: DataManagerError  = .none
        var dataManager = DataManager<YabaiSettings.State>(
            stateURLFilename: "YabaiState.json",
            configURLFilename: ".yabairc"
        )
    }
    enum Action: Equatable {
        case yabaiSettings(YabaiSettings.Action)
        case saveState
        case loadState
        case resetState
        case exportConfig
    }
}

extension Yabai {
    static let reducer = Reducer<State, Action, Void>.combine(
        YabaiSettings.reducer.pullback(
            state: \.yabaiSettings,
            action: /Action.yabaiSettings,
            environment: { _ in () }
        ),
        Reducer { state, action, _ in
            switch action {
            
            case let .yabaiSettings(subAction):
                return Effect(value: .saveState)
                
            case .saveState:
                switch state.dataManager.encodeState(state.yabaiSettings) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .encodeState
                }
                return .none
                
            case .loadState:
                switch state.dataManager.decodeState(state.yabaiSettings) {
                case let .success(decoded):
                    state.yabaiSettings = decoded
                case let .failure(error):
                    state.error = .decodeState
                }
                return .none
                
            case .resetState:
                state.yabaiSettings = YabaiSettings.State()
                return .none
                
            case .exportConfig:
                switch state.dataManager.exportConfig(state.yabaiSettings.asConfig) {
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
        environment: ()
    )
}
