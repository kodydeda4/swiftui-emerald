//
//  SKHD.swift
//  Emerald
//
//  Created by Kody Deda on 3/3/21.
//

import Foundation

import SwiftUI
import ComposableArchitecture
import SwiftShell

struct SKHD {
    struct State: Equatable {
        var skhdSettings = SKHDSettings.State()
        var skhdVersion  : String = run("/usr/local/bin/skhd", "-v").stdout
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
        case saveSKHDSettings
        case loadSKHDSettings
        case exportSKHDConfig
    }
    
    struct Environment {
        let skhdStateURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("SKHDState.json")

        
        let skhdURL = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("skhdrc")
        
        func encodeSKHDSettings(_ state: SKHDSettings.State) -> Result<Bool, Error> {
            do {
                try JSONEncoder()
                    .encode(state)
                    .write(to: skhdStateURL)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func decodeSKHDSettings(_ state: SKHDSettings.State) -> Result<(SKHDSettings.State), Error> {
            do {
                let decoded = try JSONDecoder()
                    .decode(SKHDSettings.State.self, from: Data(contentsOf: skhdStateURL))
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

extension SKHD {
    static let reducer = Reducer<State, Action, Environment>.combine(
        SKHDSettings.reducer.pullback(
            state: \.skhdSettings,
            action: /SKHD.Action.skhdSettings,
            environment: { _ in () }
        ),

        Reducer { state, action, environment in
            switch action {
            
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

extension SKHD {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}
