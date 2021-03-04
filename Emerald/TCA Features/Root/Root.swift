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

struct Root {
    struct State: Equatable {
        var yabai       = Yabai.State()
        var skhd        = SKHD.State()
        var animations  = MacOSAnimations.State()
        var onboarding  = Onboarding.State()
        var error       = DataManagerError.none
    }
    enum Action: Equatable {
        case yabai(Yabai.Action)
        case skhd(SKHD.Action)
        case animations(MacOSAnimations.Action)
        case onboarding(Onboarding.Action)
        
        case saveState(CodableState)
        case loadState(CodableState)
        case exportConfig(CodableState)
    }
    
    struct Environment {
        let homeURL = URL(fileURLWithPath: NSHomeDirectory())
        var yabaiversion = run("/usr/local/bin/yabai", "-v").stdout
        var skhdversion  = run("/usr/local/bin/skhd", "-v").stdout
        
        func encodeState<State>(_ state: State, stateURL: URL) -> Result<Bool, Error> where State : Encodable {
            do {
                try JSONEncoder()
                    .encode(state)
                    .write(to: stateURL)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func decodeState<State>(_ state: State, stateURL: URL) -> Result<State, Error> where State : Decodable {
            do {
                let decoded = try JSONDecoder()
                    .decode(type(of: state), from: Data(contentsOf: stateURL))
                return .success(decoded)
            }
            catch {
                return .failure(error)
            }
        }
        func exportConfig(_ data: String, configURL: URL) -> Result<Bool, Error> {
            do {
                let data: String = data
                try data.write(to: configURL, atomically: true, encoding: .utf8)
                
                return .success(true)
            }
            catch {
                return .failure(error)
            }
        }
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Yabai.reducer.pullback(
            state: \.yabai,
            action: /Action.yabai,
            environment: { _ in () }
        ),
        SKHD.reducer.pullback(
            state: \.skhd,
            action: /Action.skhd,
            environment: { _ in () }
        ),
        MacOSAnimations.reducer.pullback(
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
                return Effect(value: .saveState(.animations))

            case .onboarding(_):
                return .none

            case let .saveState(codableState):
                switch codableState {
                case .yabai:
                    let _ = environment.encodeState(state.yabai, stateURL: CodableState.yabai.stateURL)
                case .skhd:
                    let _ = environment.encodeState(state.skhd, stateURL: CodableState.yabai.stateURL)
                case .animations:
                    let _ = environment.encodeState(state.animations, stateURL: CodableState.yabai.stateURL)
                }
                return .none
                
            case let .loadState(codableState):
                switch codableState {
                case .yabai:
                    let _ = environment.decodeState(state.yabai, stateURL: CodableState.yabai.stateURL)
                case .skhd:
                    let _ = environment.decodeState(state.skhd, stateURL: CodableState.yabai.stateURL)
                case .animations:
                    let _ = environment.decodeState(state.animations, stateURL: CodableState.yabai.stateURL)
                }
                return .none

            case let .exportConfig(codableState):
                switch codableState {
                case .yabai:
                    let _ = environment.exportConfig(state.yabai.asConfig, configURL: CodableState.yabai.configURL)
                case .skhd:
                    let _ = environment.exportConfig(state.skhd.asConfig, configURL: CodableState.skhd.configURL)
                case .animations:
                    let _ = environment.exportConfig(state.animations.asConfig, configURL: CodableState.animations.configURL)
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

enum CodableState {
    case yabai
    case skhd
    case animations
    
    var stateURL: URL {
        let homeURL = URL(fileURLWithPath: NSHomeDirectory())
        switch self {
            
        case .yabai:
            return homeURL.appendingPathComponent("YabaiState.json")
        case .skhd:
            return homeURL.appendingPathComponent("SKHDState.json")
        case .animations:
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
        case .animations:
            return homeURL.appendingPathComponent("animations")
        }
    }
}
