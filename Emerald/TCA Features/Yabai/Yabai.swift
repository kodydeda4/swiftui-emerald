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





//extension Yabai {
//    static let reducer = Reducer<State, Action, Void>.combine(
//        Reducer { state, action, _ in
//            switch action {
//
//            case let .yabaiSettings(subAction):
//                return Effect(value: .saveState)
//
//            case .saveState:
//                switch state.dataManager.encodeState(state.yabaiSettings) {
//                case .success:
//                    state.error = .none
//                case let .failure(error):
//                    state.error = .encodeState
//                }
//                return .none
//
//            case .loadState:
//                switch state.dataManager.decodeState(state.yabaiSettings) {
//                case let .success(decoded):
//                    state.yabaiSettings = decoded
//                case let .failure(error):
//                    state.error = .decodeState
//                }
//                return .none
//
//            case .resetState:
//                state.yabaiSettings = YabaiSettings.State()
//                return .none
//
//            case .exportConfig:
//                switch state.dataManager.exportConfig(state.yabaiSettings.asConfig) {
//                case .success:
//                    state.error = .none
//                case let .failure(error):
//                    state.error = .exportConfig
//                }
//                return .none
//            }
//        }
//    )
//}
//
//extension Yabai {
//    static let defaultStore = Store(
//        initialState: .init(),
//        reducer: reducer,
//        environment: ()
//    )
//}
