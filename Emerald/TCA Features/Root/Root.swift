//
//  Root.swift
//  Emerald
//
//  Created by Kody Deda on 2/7/21.
//

import SwiftUI
import ComposableArchitecture
import Overture

struct Root {
    struct State: Equatable {
        var yabai            = Yabai.State()
        var skhd             = SKHD.State()
        var macOSAnimations  = MacOSAnimations.State()
        var homebrew         = Homebrew.State()
        var onboarding       = Onboarding.State()
        var error            = ""
    }
    
    enum Action: Equatable {
        case yabai(Yabai.Action)
        case skhd(SKHD.Action)
        case macOSAnimations(MacOSAnimations.Action)
        case homebrew(Homebrew.Action)
        case onboarding(Onboarding.Action)
        
        case restartYabai
        case save(Environment.CodableState)
        case load(Environment.CodableState)
        case reset(Environment.CodableState)
        case export(Environment.CodableState)
    }
    
    struct Environment {
        enum CodableState {
            case yabai
            case skhd
            case macOSAnimations
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
            state: \.macOSAnimations,
            action: /Action.macOSAnimations,
            environment: { _ in () }
        ),
        Homebrew.reducer.pullback(
            state: \.homebrew,
            action: /Action.homebrew,
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
                switch subAction {
                case .updateWindowOpacityDuration(_):
                    print("Debounce")
                case .updatetActiveWindowOpacity(_):
                    print("Debounce")
                case .updateNormalWindowOpacity(_):
                    print("Debounce")
                default:
                    print("")
                }
                return Effect(value: .save(.yabai))
                
            case let .skhd(subAction):
                return Effect(value: .save(.skhd))
                
            case let .macOSAnimations(subAction):
                return Effect(value: .save(.macOSAnimations))
                
            case .homebrew(_):
                return .none
                
            case .onboarding(_):
                return .none
                
            case let .save(codableState):
                
                switch codableState {
                case .yabai:
                    switch JSONEncoder().writeState(
                        state.yabai,
                        to: state.yabai.stateURL
                    ) {
                    case .success(_):
                        state.error = ""
                    case let .failure(error):
                        state.error = error.localizedDescription
                    }
                case .skhd:
                    switch JSONEncoder().writeState(
                        state.skhd,
                        to: state.skhd.stateURL
                    ) {
                    case .success(_):
                        state.error = ""
                    case let .failure(error):
                        state.error = error.localizedDescription
                    }
                case .macOSAnimations:
                    switch JSONEncoder().writeState(
                        state.macOSAnimations,
                        to: state.macOSAnimations.stateURL
                    ) {
                    case .success(_):
                        state.error = ""
                    case let .failure(error):
                        state.error = error.localizedDescription
                    }
                }
                return .none
                
            case let .load(codableState):
                switch codableState {
                case .yabai:
                    switch JSONDecoder().loadState(
                        Yabai.State.self,
                        from: state.yabai.stateURL
                    ) {
                    case let .success(decodedState):
                        state.yabai = decodedState
                    case let .failure(error):
                        state.error = error.localizedDescription
                    }
                case .skhd:
                    switch JSONDecoder().loadState(
                        SKHD.State.self,
                        from: state.skhd.stateURL
                    ) {
                    case let .success(decodedState):
                        state.skhd = decodedState
                    case let .failure(error):
                        state.error = error.localizedDescription
                    }
                case .macOSAnimations:
                    switch JSONDecoder().loadState(
                        MacOSAnimations.State.self,
                        from: state.macOSAnimations.stateURL
                    ) {
                    case let .success(decodedState):
                        state.macOSAnimations = decodedState
                    case let .failure(error):
                        state.error = error.localizedDescription
                    }
                }
                return .none
                
            case let .export(codableState):
                switch codableState {
                case .yabai:
                    switch JSONDecoder().writeConfig(
                        state.yabai.asConfig,
                        to: state.yabai.configURL
                    ) {
                    case .success(_):
                        state.error = ""
                    case let .failure(error):
                        state.error = error.localizedDescription
                    }
                case .skhd:
                    switch JSONDecoder().writeConfig(
                        state.skhd.asConfig,
                        to: state.skhd.configURL
                    ) {
                    case .success(_):
                        state.error = ""
                    case let .failure(error):
                        state.error = error.localizedDescription
                    }
                case .macOSAnimations:
                    switch JSONDecoder().writeConfig(
                        state.macOSAnimations.asConfig,
                        to: state.macOSAnimations.configURL
                    ) {
                    case .success(_):
                        state.error = ""
                    case let .failure(error):
                        state.error = error.localizedDescription
                    }
                }
                return .none
                
            case let .reset(codableState):
                switch codableState {
                case .yabai:
                    state.yabai = Yabai.State()
                case .skhd:
                    state.skhd = SKHD.State()
                case .macOSAnimations:
                    state.macOSAnimations = MacOSAnimations.State()
                }
                return .none
                
            case .restartYabai:
                state.error = AppleScript.restartYabai.execute()
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

