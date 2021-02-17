//
//  DataManager.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/17/21.
//

import ComposableArchitecture

struct DataManager {
    struct State: Equatable {
        var yabaiSettings = YabaiSettings.State()
        var skhdSettings = SKHDSettings.State()
        var error: Error = .none
        
        enum Error {
            case saveYabaiSettings
            case loadYabaiSettings
            case exportYabaiConfig
            
            case saveSKHDSettings
            case loadSKHDSettings
            case exportSKHDConfig
            case none
        }
    }
    
    enum Action: Equatable {
        case yabaiSettings(YabaiSettings.Action)
        case saveYabaiSettings
        case loadYabaiSettings
        case exportYabaiConfig
        
        case skhdSettings(SKHDSettings.Action)
        case saveSKHDSettings
        case loadSKHDSettings
        case exportSKHDConfig
    }
    
    struct Environment {
        //MARK:- YABAI
        
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
        
        //MARK:- SKHD
        
        let skhdURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("skhdConfig")
        
        func encodeSKHDSettings(_ state: SKHDSettings.State) -> Result<Bool, Error> {
            do {
                try JSONEncoder()
                    .encode(state)
                    .write(to: skhdURL)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func decodeSKHDSettings(_ state: SKHDSettings.State) -> Result<(SKHDSettings.State), Error> {
            do {
                let decoded = try JSONDecoder()
                    .decode(SKHDSettings.State.self, from: Data(contentsOf: skhdURL))
                return .success(decoded)
            }
            catch {
                return .failure(error)
            }
        }
        func exportSKHDConfig(_ skhdSettingsState: SKHDSettings.State) -> Result<Bool, Error> {
            do {
                let data: String = skhdSettingsState.asConfig
                try data.write(to: skhdURL, atomically: true, encoding: .utf8)
                
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
        SKHDSettings.reducer.pullback(
            state: \.skhdSettings,
            action: /DataManager.Action.skhdSettings,
            environment: { _ in () }
        ),
        Reducer { state, action, environment in
            switch action {
            
            // MARK:- YABAI
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
                
            // MARK:- SKHD
            
            case let .skhdSettings(subAction):
                return Effect(value: .saveSKHDSettings)
                    
            case .saveSKHDSettings:
                switch environment.encodeSKHDSettings(state.skhdSettings) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .saveSKHDSettings
                }
                return .none
                
            case .loadSKHDSettings:
                switch environment.decodeSKHDSettings(state.skhdSettings) {
                case let .success(decoded):
                    state.skhdSettings = decoded
                case let .failure(error):
                    state.error = .loadSKHDSettings
                }
                return .none
                
            case .exportSKHDConfig:
                switch environment.exportSKHDConfig(state.skhdSettings) {
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

extension DataManager {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}
