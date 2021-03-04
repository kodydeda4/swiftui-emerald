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
        var yabai            = Yabai.State()
        var skhd             = SKHD.State()
        var macOSAnimations  = MacOSAnimations.State()
        var onboarding       = Onboarding.State()
        //var error: Error?    = nil
    }
    enum Action: Equatable {
        case yabai(Yabai.Action)
        case skhd(SKHD.Action)
        case macOSAnimations(MacOSAnimations.Action)
        case onboarding(Onboarding.Action)
        
        case saveState(CodableState)
        case loadState(CodableState)
        case exportConfig(CodableState)
    }
    
    struct Environment {
        var yabaiVersion = run("/usr/local/bin/yabai", "-v").stdout
        var skhdVersion  = run("/usr/local/bin/skhd", "-v").stdout
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
            state: \.macOSAnimations,
            action: /Action.macOSAnimations,
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
                
            case let .macOSAnimations(subAction):
                return Effect(value: .saveState(.macOSAnimations))

            case .onboarding(_):
                return .none

            case let .saveState(codableState):
                let url = codableState.configURL
                
                switch codableState {
                case .yabai:
                    let _ = JSONEncoder().writeState(state.yabai, to: url)
                case .skhd:
                    let _ = JSONEncoder().writeState(state.skhd, to: url)
                case .macOSAnimations:
                    let _ = JSONEncoder().writeState(state.macOSAnimations, to: url)
                }
                return .none
                
            case let .loadState(codableState):
                let url = codableState.configURL
                
                switch codableState {
                case .yabai:
                    let _ = JSONDecoder().loadState(Yabai.State.self, from: url)
                case .skhd:
                    let _ = JSONDecoder().loadState(SKHD.State.self, from: url)
                case .macOSAnimations:
                    let _ = JSONDecoder().loadState(MacOSAnimations.State.self, from: url)
                }
                return .none

            case let .exportConfig(codableState):
                let url = codableState.configURL

                switch codableState {
                case .yabai:
                    let _ = JSONDecoder().writeConfig(state.yabai.asConfig, to: url)
                case .skhd:
                    let _ = JSONDecoder().writeConfig(state.skhd.asConfig, to: url)
                case .macOSAnimations:
                    let _ = JSONDecoder().writeConfig(state.macOSAnimations.asConfig, to: url)
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
    case macOSAnimations
    
    var stateURL: URL {
        let homeURL = URL(fileURLWithPath: NSHomeDirectory())
        switch self {
            
        case .yabai:
            return homeURL.appendingPathComponent("YabaiState.json")
        case .skhd:
            return homeURL.appendingPathComponent("SKHDState.json")
        case .macOSAnimations:
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
        case .macOSAnimations:
            return homeURL.appendingPathComponent("animations")
        }
    }
}
