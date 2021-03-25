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

/*
 Fix multiple sheets
 - multiple .sheet modifiers doesn't work.
 - the fix - have one sheetview, that changes depending on the action sent.
  */

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
        
        var powerButtonAnimating = false
        var applyChangesButtonAnimating = false
    }
    
    enum Action: Equatable {
        case onAppear
        case save
        
        //Features
        case yabai(Yabai.Action)
        case skhd(SKHD.Action)
        case macOSAnimations(MacOSAnimations.Action)
        case homebrew(Homebrew.Action)
        case onboarding(Onboarding.Action)
        
        //ToolbarButtons
        case sidebarButtonTapped
        case keyboardButtonTapped
        case lockButtonTapped
        
        //ResetAlert
        case resetButtonTapped
        case dismissResetAlert
        case confirmResetAlert

        //PowerButton
        case powerButtonTapped
        case powerButtonAnimation
        
        //ApplyChangesButton
        case applyChangesButtonTapped
        case applyChangesButtonAnimation
    }
    
    struct Environment {
        func writeState<State>(_ state: State, to url: URL) -> Result<Bool, Error> where State: Codable {
            let startDate = Date()
            
            print("writeState: to: '\(url.path)'")
            do {
                try JSONEncoder()
                    .encode(state)
                    .write(to: url)
                
                print("\(Date()) elapsed: '\(startDate.timeIntervalSinceNow * -1000) ms'")
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        
        func decodeState<State>(_ type: State.Type, from url: URL) -> Result<State, Error> where State: Codable {
            do {
                let decoded = try JSONDecoder().decode(type.self, from: Data(contentsOf: url))
                return .success(decoded)
            }
            catch {
                return .failure(error)
            }
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
            
            case .onAppear:
                switch environment.decodeState(Yabai.State.self, from: state.yabai.stateURL) {
                case let .success(decodedState):
                    state.yabai = decodedState
                case let .failure(error):
                    state.error = error.localizedDescription
                }
                switch environment.decodeState(SKHD.State.self, from: state.skhd.stateURL) {
                case let .success(decodedState):
                    state.skhd = decodedState
                case let .failure(error):
                    state.error = error.localizedDescription
                }
                switch environment.decodeState(MacOSAnimations.State.self, from: state.macOSAnimations.stateURL) {
                case let .success(decodedState):
                    state.macOSAnimations = decodedState
                case let .failure(error):
                    state.error = error.localizedDescription
                }
                return .none
            
            case .save:
                let _ = environment.writeState(state.yabai, to: state.yabai.stateURL)
                let _ = environment.writeState(state.skhd,  to: state.skhd.stateURL)
                let _ = environment.writeState(state.macOSAnimations, to: state.macOSAnimations.stateURL)
                let _ = environment.writeConfig(state.yabai.asConfig, to: state.yabai.configURL)
                let _ = environment.writeConfig(state.skhd.asConfig,  to: state.skhd.configURL)
                let _ = environment.writeConfig(state.macOSAnimations.asShellScript, to: state.macOSAnimations.shellScriptURL)
                return .none

            case .yabai, .skhd, .macOSAnimations:
                return Effect(value: .save)
                
            case .homebrew, .onboarding:
                return .none
                
            case .sidebarButtonTapped:
                NSApp.keyWindow?
                    .firstResponder?
                    .tryToPerform(#selector(NSSplitViewController.toggleSidebar), with: nil)
                return .none
                
            case .keyboardButtonTapped:
                return Effect(value: .homebrew(.toggleSKHD))

            case .lockButtonTapped:
                return Effect(value: .yabai(.toggleSIP))

            case .resetButtonTapped:
                state.alert = .init(
                    title: TextState("Reset Settings?"),
                    message: TextState("You cannot undo this action."),
                    primaryButton: .destructive(TextState("Confirm"), send: .confirmResetAlert),
                    secondaryButton: .cancel()
                )
                return .none

            case .dismissResetAlert:
                state.alert = nil
                return .none

            case .confirmResetAlert:
                state = Root.State()
                KeyboardShortcuts.resetEmeraldDefaults()
                return Effect(value: .save)
                
            case .powerButtonTapped:
                let _ = AppleScript.execute("/usr/local/bin/brew services \(state.disabled ? "start" : "stop") yabai")
                let _ = AppleScript.execute("/usr/local/bin/brew services \(state.disabled ? "start" : "stop") skhd")
                state.disabled.toggle()

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
                let _ = AppleScript.execute("/usr/local/bin/brew services restart yabai")
                //state.applyChanges.toggle()
                
                return Effect(value: .applyChangesButtonAnimation)
                
            case .applyChangesButtonAnimation:
                state.applyChangesButtonAnimating.toggle()
                
                if state.applyChangesButtonAnimating {
                    return Effect(value: .applyChangesButtonAnimation)
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
