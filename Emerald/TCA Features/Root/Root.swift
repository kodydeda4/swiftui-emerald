//
//  Root.swift
//  Emerald
//
//  Created by Kody Deda on 2/7/21.
//

import SwiftUI
import ComposableArchitecture
import Overture
import Combine

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
        case saveResult(Result<Bool, CacheError>)
//        case save(Environment.CodableState)
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
        
//        func savePublisher<Value>(_ value: Value, to url: URL) -> AnyPublisher<(Value, URL), CacheError> where Value: Codable {
//            let foo = Just((value, url))
//                .setFailureType(to: CacheError.self)
//                .eraseToAnyPublisher()
//            return foo
//        }
//
//        func save<Value>(_ value: Value, to url: URL) -> Effect<Action, Never> where Value: Codable {
//            //            let result = JSONEncoder().writeState(
//            //                value,
//            //                to: url
//            //            )
//
//            // TODO
//            // slight cheat ...
//            let foo11 = savePublisher(value, to: url)
//                .map { (tuple) -> Result<Bool, CacheError> in
//                    let rv = JSONEncoder().writeState(
//                        tuple.0,
//                        to: tuple.1
//                    )
//                    return rv
//                }
//                .eraseToAnyPublisher()
////                .eraseToEffect()
////
////                .map(Action.saveResult)
//
//            //
//            //                .map { _ in
//            //                }
//            //                .eraseToEffect()
//
////            return foo
//        }

        func save<Value>(_ value: Value, to url: URL) -> Effect<Action, Never> where Value: Codable {
            let result = JSONEncoder().writeState(
                value,
                to: url
            )

            // TODO
            // this will cause the debounce to not work ....
            let foo = Just(result)
                .map(Action.saveResult)
                .eraseToEffect()
            return foo
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
            struct SaveID: Hashable {}
            
            switch action {
            case let .yabai(subAction):
                switch subAction {
                case .updateWindowOpacityDuration,
                     .updatetActiveWindowOpacity,
                     .updateNormalWindowOpacity:
                    print("Debounce this ... \(subAction)")
                    return environment
                        .save(state.yabai, to: state.yabai.stateURL)
                        .debounce(id: SaveID(), for: 1.0, scheduler: DispatchQueue.main.eraseToAnyScheduler())
                default:
                    return environment.save(state.yabai, to: state.yabai.stateURL)
                }
                
            case .skhd:
                return environment.save(state.skhd, to: state.skhd.stateURL)

            case let .macOSAnimations(subAction):
                return environment.save(state.macOSAnimations, to: state.macOSAnimations.stateURL)
                
            case .homebrew(_):
                return .none
                
            case .onboarding(_):
                return .none
                                
            case .saveResult(.success(_)):
                state.error = ""
                print("We saved ... ")
                return .none
                
            case let .saveResult(.failure(error)):
                state.error = error.localizedDescription
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

