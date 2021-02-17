//
//  DataManager.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/17/21.
//

import SwiftUI
import ComposableArchitecture

struct DataManager {
    struct State: Equatable {
        var yabaiSettings = YabaiSettings.State()
        var error: Error = .none
        
        enum Error {
            case saveFile
            case loadFile
            case exportFile
            case none
        }
    }
    
    enum Action: Equatable {
        case yabaiSettings(YabaiSettings.Action)
        case saveYabaiSettings
        case loadYabaiSettings
        case exportYabaiConfig
    }
    
    struct Environment {
        let yabaiURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("yabaiConfig")
        
        func encodeYabaiSettings(_ state: YabaiSettings.State) -> Result<Bool, Error> {
            do {
                try JSONEncoder()
                    .encode(state)
                    .write(to: yabaiURL)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func decodeYabaiSettings(_ state: YabaiSettings.State) -> Result<(YabaiSettings.State), Error> {
            do {
                let decoded = try JSONDecoder()
                    .decode(YabaiSettings.State.self, from: Data(contentsOf: yabaiURL))
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
        }
    }
}

extension DataManager {
    static let reducer = Reducer<State, Action, Environment>.combine(
        YabaiSettings.reducer.pullback(
            state: \.yabaiSettings,
            action: /DataManager.Action.yabaiSettings,
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
                    state.error = .saveFile
                }
                return .none
                
            case .loadYabaiSettings:
                switch environment.decodeYabaiSettings(state.yabaiSettings) {
                case let .success(decoded):
                    state.yabaiSettings = decoded
                case let .failure(error):
                    state.error = .loadFile
                }
                return .none
                
                
            case .exportYabaiConfig:
                switch environment.exportYabaiConfig(state.yabaiSettings) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .exportFile
                }
                return .none
            }
        }
    )
}

extension DataManager {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}
