//
//  Root.swift
//  Emerald
//
//  Created by Kody Deda on 2/7/21.
//

import ComposableArchitecture
import SwiftShell
import SwiftUI

// Optimal Solution ??? modifier on the reducer - if state is codable, it saves/loads state automatically

enum CodableState {
    case yabai
    case skhd
    case animation
    
    var stateURL: URL {
        let homeURL = URL(fileURLWithPath: NSHomeDirectory())
        switch self {
            
        case .yabai:
            return homeURL.appendingPathComponent("YabaiState.json")
        case .skhd:
            return homeURL.appendingPathComponent("SKHDState.json")
        case .animation:
            return homeURL.appendingPathComponent("AnimationsState.json")
        }
    }
    var configURL: URL {
        let homeURL = URL(fileURLWithPath: NSHomeDirectory())
        switch self {
        case .yabai:
            return homeURL.appendingPathComponent("yabai")
        case .skhd:
            return homeURL.appendingPathComponent("skhd")
        case .animation:
            return homeURL.appendingPathComponent("animations")
        }
    }
}

struct Root {
    struct State: Equatable {
        var yabai       = YabaiSettings.State()
        var skhd        = SKHDSettings.State()
        var animations  = AnimationSettings.State()
        var onboarding  = Onboarding.State()
        
        
        var error: DataManagerError = .none
    }
    enum Action: Equatable {
        case yabai(YabaiSettings.Action)
        case skhd(SKHDSettings.Action)
        case animations(AnimationSettings.Action)
        case onboarding(Onboarding.Action)
        
        case saveState(CodableState)
        case loadState(CodableState)
        case exportConfig(CodableState)
    }
    
    struct Environment {
        let homeURL = URL(fileURLWithPath: NSHomeDirectory())
        var yabaiversion = run("/usr/local/bin/yabai", "-v").stdout
        var skhdversion  = run("/usr/local/bin/skhd", "-v").stdout
        
        
        func encodeState<State>(_ state: State, stateURL: URL) -> Result<Bool, DataManagerError> where State : Encodable {
            do {
                try JSONEncoder()
                    .encode(state)
                    .write(to: stateURL)
                return .success(true)
            } catch {
                return .failure(.encodeState)
            }
        }
        func decodeState<State>(_ state: State, stateURL: URL) -> Result<State, DataManagerError> where State : Decodable {
            do {
                let decoded = try JSONDecoder()
                    .decode(type(of: state), from: Data(contentsOf: stateURL))
                return .success(decoded)
            }
            catch {
                return .failure(.decodeState)
            }
        }
        func exportConfig(_ data: String, configURL: URL) -> Result<Bool, DataManagerError> {
            do {
                let data: String = data
                try data.write(to: configURL, atomically: true, encoding: .utf8)
                
                return .success(true)
            }
            catch {
                return .failure(.exportConfig)
            }
        }
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Environment>.combine(
        YabaiSettings.reducer.pullback(
            state: \.yabai,
            action: /Action.yabai,
            environment: { _ in () }
        ),
        SKHDSettings.reducer.pullback(
            state: \.skhd,
            action: /Action.skhd,
            environment: { _ in () }
        ),
        AnimationSettings.reducer.pullback(
            state: \.animations,
            action: /Action.animations,
            environment: { _ in () }
        ),
        Onboarding.reducer.pullback(
            state: \.onboarding,
            action: /Action.onboarding,
            environment: { _ in () }
        ),
        Reducer { state, action, environment in
            switch action {
            case let .yabai(subAction):
                return Effect(value: .saveState(.yabai))
                
            case let .skhd(subAction):
                return Effect(value: .saveState(.skhd))
                
            case let .animations(subAction):
                return Effect(value: .saveState(.animation))

            case .onboarding(_):
                return .none

            case let .saveState(codableState):
                switch codableState {
                case .animation:
                    switch environment.encodeState(state.animations, stateURL: codableState.stateURL) {
                    case .success:
                        state.error = .none
                    case let .failure(error):
                        state.error = .encodeState
                    }
                case .yabai:
                    switch environment.encodeState(state.yabai, stateURL: codableState.stateURL) {
                    case .success:
                        state.error = .none
                    case let .failure(error):
                        state.error = .encodeState
                    }
                case .skhd:
                    switch environment.encodeState(state.skhd, stateURL: codableState.stateURL) {
                    case .success:
                        state.error = .none
                    case let .failure(error):
                        state.error = .encodeState
                    }
                }
                return .none
                
            case let .loadState(codableState):
                switch codableState {
                case .animation:
                    switch environment.decodeState(state.animations, stateURL: codableState.stateURL) {
                    case let .success(decoded):
                        state.animations = decoded
                    case let .failure(error):
                        state.error = .decodeState
                    }
                case .yabai:
                    switch environment.decodeState(state.yabai, stateURL: codableState.stateURL) {
                    case let .success(decoded):
                        state.yabai = decoded
                    case let .failure(error):
                        state.error = .decodeState
                    }
                case .skhd:
                    switch environment.decodeState(state.skhd, stateURL: codableState.stateURL) {
                    case let .success(decoded):
                        state.skhd = decoded
                    case let .failure(error):
                        state.error = .decodeState
                    }
                }
            return .none
                
            case let .exportConfig(codableState):
                switch codableState {
                case .animation:
                    switch environment.exportConfig(state.animations.asConfig, configURL: codableState.configURL) {
                    case .success:
                        state.error = .none
                    case let .failure(error):
                        state.error = .exportConfig
                    }
                case .yabai:
                    switch environment.exportConfig(state.yabai.asConfig, configURL: codableState.configURL) {
                    case .success:
                        state.error = .none
                    case let .failure(error):
                        state.error = .exportConfig
                    }
                case .skhd:
                    switch environment.exportConfig(state.animations.asConfig, configURL: codableState.configURL) {
                    case .success:
                        state.error = .none
                    case let .failure(error):
                        state.error = .exportConfig
                    }
                }
                return .none
            }
        }
    )
}

extension Root {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}
