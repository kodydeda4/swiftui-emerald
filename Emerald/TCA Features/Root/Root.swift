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
import KeyboardShortcuts

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
        case appleScript(AppleScript)
        case saveResult(Result<Bool, CacheError>)
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
        
        func savePublisher<Value>(_ value: Value, to url: URL) -> AnyPublisher<(Value, URL), Never> where Value: Codable {
            let foo = Just((value, url))
                .eraseToAnyPublisher()
            return foo
        }
        
        func save<Value>(_ value: Value, to url: URL) -> Effect<Action, Never> where Value: Codable {
            let foo = savePublisher(value, to: url)
                .map { (tuple) -> Result<Bool, CacheError> in
                    let rv = JSONEncoder().writeState(
                        tuple.0,
                        to: tuple.1
                    )
                    return rv
                }
                .eraseToAnyPublisher()
                .eraseToEffect()
                .map(Action.saveResult)
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
//                switch subAction {
//                case .updateWindowOpacityDuration,
//                     .updatetActiveWindowOpacity,
//                     .updateNormalWindowOpacity:
//                    print("\(Date()) Debounce this ... \(subAction)")
//                    return environment
//                        .save(state.yabai, to: state.yabai.stateURL)
////                        .debounce(id: SaveID(), for: 0.1, scheduler: DispatchQueue.main.eraseToAnyScheduler())
//
//                default:
//                    return environment.save(state.yabai, to: state.yabai.stateURL)
//                }
                return environment.save(state.yabai, to: state.yabai.stateURL)
                
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
                    KeyboardShortcuts.reset(KeyboardShortcuts.Name.allCases)
                    state.skhd = SKHD.State()
                    
                    KeyboardShortcuts.set(.restartYabai,   [.option, .shift             ], .r)
                    
                    KeyboardShortcuts.set(.togglePadding,  [.option,                    ], .seven)
                    KeyboardShortcuts.set(.toggleGaps,     [.option,                    ], .eight)
                    KeyboardShortcuts.set(.toggleSplit,    [.option,                    ], .nine)
                    KeyboardShortcuts.set(.toggleBalance,  [.option,                    ], .zero)
  
                      
                    KeyboardShortcuts.set(.toggleFloating, [.option, .shift             ], .one)
                    KeyboardShortcuts.set(.toggleBSP,      [.option, .shift             ], .two)
                    KeyboardShortcuts.set(.toggleStacking, [.option, .shift             ], .three)
                                 
                    KeyboardShortcuts.set(.focusNorth,     [.control,                   ], .upArrow)
                    KeyboardShortcuts.set(.focusSouth,     [.control,                   ], .downArrow)
                    KeyboardShortcuts.set(.focusEast,      [.control,                   ], .rightArrow)
                    KeyboardShortcuts.set(.focusWest,      [.control,                   ], .leftArrow)
                      
                    KeyboardShortcuts.set(.resizeTop,      [.control, .option,          ], .upArrow)
                    KeyboardShortcuts.set(.resizeBottom,   [.control, .option,          ], .downArrow)
                    KeyboardShortcuts.set(.resizeRight,    [.control, .option,          ], .rightArrow)
                    KeyboardShortcuts.set(.resizeLeft,     [.control, .option,          ], .leftArrow)
                     
                    KeyboardShortcuts.set(.moveNorth,      [.control, .option, .command,], .upArrow)
                    KeyboardShortcuts.set(.moveSouth,      [.control, .option, .command,], .downArrow)
                    KeyboardShortcuts.set(.moveEast,       [.control, .option, .command,], .rightArrow)
                    KeyboardShortcuts.set(.moveWest,       [.control, .option, .command,], .leftArrow)


                    
                case .macOSAnimations:
                    state.macOSAnimations = MacOSAnimations.State()
                }
                return .none
                
            case let .appleScript(appleScript):
                state.error = appleScript.execute()
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
