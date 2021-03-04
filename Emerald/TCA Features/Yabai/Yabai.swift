//
//  Yabai.swift
//  Emerald
//
//  Created by Kody Deda on 3/3/21.
//

import Foundation

import SwiftUI
import ComposableArchitecture
import SwiftShell


struct Yabai {
    struct State: Equatable {
        var yabaiSettings = YabaiSettings.State()
        var yabaiVersion : String = run("/usr/local/bin/yabai", "-v").stdout
        var error: Error = .none

        enum Error {
            case saveYabaiSettings
            case loadYabaiSettings
            case exportYabaiConfig
            case none
        }
    }
    
    enum Action: Equatable {
        case yabaiSettings(YabaiSettings.Action)
        case saveYabaiSettings
        case loadYabaiSettings
        case exportYabaiConfig
        case resetYabaiSettings
    }
    
    struct Environment {
        let yabaiStateURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("YabaiState.json")
        
        let yabaiURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent(".yabairc")
        
        func encodeYabaiSettings(_ state: YabaiSettings.State) -> Result<Bool, Error> {
            do {
                try JSONEncoder()
                    .encode(state)
                    .write(to: yabaiStateURL)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func decodeYabaiSettings(_ state: YabaiSettings.State) -> Result<(YabaiSettings.State), Error> {
            do {
                let decoded = try JSONDecoder()
                    .decode(YabaiSettings.State.self, from: Data(contentsOf: yabaiStateURL))
                return .success(decoded)
            }
            catch {
                return .failure(error)
            }
        }
        func exportYabaiConfig(_ yabaiSettingsState: YabaiSettings.State) -> Result<Bool, Error> {
            do {
                let data: String = yabaiSettingsState.asConfig
                try data.write(to: yabaiURL, atomically: true, encoding: .utf8)
                
                return .success(true)
            }
            catch {
                return .failure(error)
            }
        }    }
}

extension Yabai {
    static let reducer = Reducer<State, Action, Environment>.combine(
        YabaiSettings.reducer.pullback(
            state: \.yabaiSettings,
            action: /Yabai.Action.yabaiSettings,
            environment: { _ in () }
        ),

        Reducer { state, action, environment in
            switch action {
            case let .yabaiSettings(subAction):
                return Effect(value: .saveYabaiSettings)
                    
            case .saveYabaiSettings:
                switch environment.encodeYabaiSettings(state.yabaiSettings) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .saveYabaiSettings
                }
                return .none
                
            case .loadYabaiSettings:
                switch environment.decodeYabaiSettings(state.yabaiSettings) {
                case let .success(decoded):
                    state.yabaiSettings = decoded
                case let .failure(error):
                    state.error = .loadYabaiSettings
                }
                return .none
                
            case .exportYabaiConfig:
                switch environment.exportYabaiConfig(state.yabaiSettings) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .exportYabaiConfig
                }
                return .none
                
            case .resetYabaiSettings:
                state.yabaiSettings = YabaiSettings.State()
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
