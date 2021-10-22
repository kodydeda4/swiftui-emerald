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
 Todos:
 
 1. Onboarding screen
 - click through and download homebrew, yabai, skhd
 
 2. About
 - show what version everything is running
 
 3. Distribute Package
 
 4. Test on guest account
 
 5. Fix save state file location
 - app directory not home directory
 
 6. Remove or add to sidebar
 
 */
struct Root {
  struct State: Equatable {
    var disabled    = false
    var yabai       = Yabai.State()
    var skhd        = SKHD.State()
    var homebrew    = Homebrew.State()
    var onboarding  = Onboarding.State()
    var alert       : AlertState<Root.Action>?
    var error       = ""
    
    var sheetView = false
    var animatingApplyChanges = false
    var animatingTogglePower = false
  }
  
  enum Action: Equatable {
    case onAppear
    case save
    case toggleSheetView
    case installProgramsButtonTapped
    
    //Features
    case yabai(Yabai.Action)
    case skhd(SKHD.Action)
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
    
    //ApplyChangesButton
    case applyChangesButtonTapped
  }
  
  struct Environment {
    //
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
      
      case .installProgramsButtonTapped:
        let installHomebrew = AppleScript.execute("/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"")
        let installYabai    = AppleScript.execute("/usr/local/bin/brew install yabai")
        let installSKHD     = AppleScript.execute("/usr/local/bin/brew install skhd")
        
        return .none
        
      case .onAppear:
        switch JSONDecoder().decodeState(Yabai.State.self, from: state.yabai.stateURL) {
        case let .success(decodedState):
          state.yabai = decodedState
        case let .failure(error):
          state.error = error.localizedDescription
        }
        switch JSONDecoder().decodeState(SKHD.State.self, from: state.skhd.stateURL) {
        case let .success(decodedState):
          state.skhd = decodedState
        case let .failure(error):
          state.error = error.localizedDescription
        }
        return .none
        
      case .save:
        let _ = JSONEncoder().writeState(state.yabai, to: state.yabai.stateURL)
        let _ = JSONEncoder().writeState(state.skhd,  to: state.skhd.stateURL)
        let _ = JSONEncoder().writeConfig(state.yabai.asConfig, to: state.yabai.configURL)
        let _ = JSONEncoder().writeConfig(state.skhd.asConfig,  to: state.skhd.configURL)
        return .none
        
      case .yabai, .skhd:
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
        
        let _ = JSONEncoder().writeState(state.yabai, to: state.yabai.stateURL)
        let _ = JSONEncoder().writeState(state.skhd,  to: state.skhd.stateURL)
        let _ = JSONEncoder().writeConfig(state.yabai.asConfig, to: state.yabai.configURL)
        let _ = JSONEncoder().writeConfig(state.skhd.asConfig,  to: state.skhd.configURL)
        
        let _ = AppleScript.execute("/usr/local/bin/brew services restart yabai; /usr/local/bin/brew services restart skhd;")
        return Effect(value: .applyChangesButtonTapped)
        
      case .powerButtonTapped:
        var startStop: String { state.disabled ? "start" : "stop" }
        let _ = AppleScript.execute("/usr/local/bin/brew services \(startStop) yabai; /usr/local/bin/brew services \(startStop) skhd;")
        state.disabled.toggle()
        state.animatingTogglePower.toggle()
        if state.animatingTogglePower {
          return Effect(value: .toggleSheetView)
        }
        state.animatingTogglePower.toggle()
        
        return Effect(value: .toggleSheetView)
        
        
      case .applyChangesButtonTapped:
        let _ = AppleScript.execute("/usr/local/bin/brew services restart yabai; /usr/local/bin/brew services restart skhd;")
        state.animatingApplyChanges.toggle()
        if state.animatingApplyChanges {
          return Effect(value: .toggleSheetView)
        }
        state.animatingApplyChanges.toggle()
        return Effect(value: .toggleSheetView)
        
        
      case .toggleSheetView:
        state.sheetView.toggle()
        
        if state.sheetView {
          return Effect(value: .toggleSheetView)
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
