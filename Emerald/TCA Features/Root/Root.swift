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
        var disabled         = false
        var yabai            = Yabai.State()
        var skhd             = SKHD.State()
        var macOSAnimations  = MacOSAnimations.State()
        var homebrew         = Homebrew.State()
        var onboarding       = Onboarding.State()
        var alert            : AlertState<Root.Action>?
        var error            = ""
        
        var powerButtonAnimating        = false
        var applyChangesButtonAnimating = false
    }
    enum Action: Equatable {
        case yabai(Yabai.Action)
        case skhd(SKHD.Action)
        case macOSAnimations(MacOSAnimations.Action)
        case homebrew(Homebrew.Action)
        case onboarding(Onboarding.Action)
        case resetButtonTapped
        case dismissResetAlert
        case confirmResetAlert
        case saveResult(Result<Bool, CacheError>)
        case load(Environment.CodableState)
        case export(Environment.CodableState)
        
        case sidebarButtonTapped
        case keyboardButtonTapped
        case lockButtonTapped
        case powerButtonTapped
        case powerButtonAnimation
        case applyChangesButtonTapped
        case applyChangesButtonAnimation
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
        
        func writeConfig(_ config: String, to url: URL) -> Result<Bool, Error> {
            do {
                let data: String = config
                try data.write(to: url, atomically: true, encoding: .utf8)
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
            case .yabai:
                let _ = environment.writeConfig(state.yabai.asConfig, to: state.yabai.configURL)
                let _ = environment.save(state.yabai, to: state.yabai.stateURL)
                return .none
                
            case .skhd:
                let _ = environment.writeConfig(state.skhd.asConfig, to: state.skhd.configURL)
                let _ = environment.save(state.skhd, to: state.skhd.stateURL)
                return .none
                
            case let .macOSAnimations(subAction):
                let _ = environment.writeConfig(state.macOSAnimations.asShellScript, to: state.macOSAnimations.shellScriptURL)
                let _ = environment.save(state.macOSAnimations, to: state.macOSAnimations.stateURL)
                return .none
                
            case .homebrew:
                return .none
                
            case .onboarding:
                return .none
                
            case .sidebarButtonTapped:
                NSApp.keyWindow?
                    .firstResponder?
                    .tryToPerform(#selector(NSSplitViewController.toggleSidebar), with: nil)
                return .none

            case .saveResult(.success):
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
                    case .success:
                        state.error = ""
                    case let .failure(error):
                        state.error = error.localizedDescription
                    }
                case .skhd:
                    switch JSONDecoder().writeConfig(
                        state.skhd.asConfig,
                        to: state.skhd.configURL
                    ) {
                    case .success:
                        state.error = ""
                    case let .failure(error):
                        state.error = error.localizedDescription
                    }
                case .macOSAnimations:
                    switch JSONDecoder().writeConfig(
                        state.macOSAnimations.asShellScript,
                        to: state.macOSAnimations.shellScriptURL
                    ) {
                    case .success:
                        state.error = ""
                    case let .failure(error):
                        state.error = error.localizedDescription
                    }
                }
                return .none
                                                
            case .resetButtonTapped:
                state.alert = .init(
                    title: TextState("Reset Settings?"),
                    message: TextState("You cannot undo this action."),
                    primaryButton: .destructive(TextState("Confirm"), send: .confirmResetAlert),
                    secondaryButton: .cancel()
                )
                return .none
                
            case .confirmResetAlert:
                state.yabai = Yabai.State()
                state.skhd = SKHD.State()
                state.macOSAnimations = MacOSAnimations.State()
                
                let _ = environment.writeConfig(state.yabai.asConfig, to: state.yabai.configURL)
                let _ = environment.save(state.yabai, to: state.yabai.stateURL)
                
                let _ = environment.writeConfig(state.skhd.asConfig, to: state.yabai.configURL)
                let _ = environment.save(state.skhd, to: state.skhd.stateURL)

                let _ = environment.writeConfig(state.macOSAnimations.asShellScript, to: state.macOSAnimations.shellScriptURL)
                let _ = environment.save(state.macOSAnimations, to: state.macOSAnimations.stateURL)


                KeyboardShortcuts.reset(KeyboardShortcuts.Name.allCases)
                state.skhd = SKHD.State()
                
                KeyboardShortcuts.set(.restartYabai,   [.option, .shift             ], .r)
                
                KeyboardShortcuts.set(.gaps,           [.control, .option,          ], .g)
                KeyboardShortcuts.set(.padding,        [.control, .option,          ], .h)
                KeyboardShortcuts.set(.split,          [.control, .option,          ], .x)
                KeyboardShortcuts.set(.balance,        [.control, .option,          ], .b)
                
                
                
                KeyboardShortcuts.set(.float,          [.control, .option,          ], .one)
                KeyboardShortcuts.set(.bsp,            [.control, .option,          ], .two)
                KeyboardShortcuts.set(.stack,          [.control, .option,          ], .three)

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

                
                state.alert = nil
                return Effect(value: .homebrew(.restartYabai))
                
            case .lockButtonTapped:
                return Effect(value: .yabai(.toggleSIP))
                
            case .keyboardButtonTapped:
                return Effect(value: .homebrew(.toggleSKHD))
                                    
            case .dismissResetAlert:
                state.alert = nil
                return .none
                
            case .powerButtonTapped:
                state.disabled.toggle()
//                return Effect(value: .homebrew(.toggleYabai))
//                    .delay(for: 2.0, scheduler: DispatchQueue.main)
//                    .eraseToEffect()
                return Effect(value: .powerButtonAnimation)

                
            case .powerButtonAnimation:
                state.powerButtonAnimating.toggle()
                
                if state.powerButtonAnimating {
                    return Effect(value: .powerButtonAnimation)
                        .delay(for: 2.0, scheduler: DispatchQueue.main)
                        .eraseToEffect()
                }
                return .none
                
            case .applyChangesButtonTapped:
                //                        viewStore.send(.toggleApplyingChanges)
                //                        viewStore.send(.export(.yabai))
                //                        viewStore.send(.export(.skhd))
                //                        viewStore.send(.homebrew(.restartYabai))
                return Effect(value: .applyChangesButtonAnimation)
                
            case .applyChangesButtonAnimation:
                state.applyChangesButtonAnimating.toggle()
                
                if state.applyChangesButtonAnimating {
                    return Effect(value: .powerButtonAnimation)
                        .delay(for: 2.0, scheduler: DispatchQueue.main)
                        .eraseToEffect()
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
