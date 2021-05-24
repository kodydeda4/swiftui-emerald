//
//  SKHDSettings.swift
//  Emerald
//
//  Created by Kody Deda on 2/17/21.
//

import ComposableArchitecture
import KeyboardShortcuts
import SwiftShell


struct SKHD {
    struct State: Equatable, Codable {
        var stateURL  = Bundle.main.bundleURL.appendingPathComponent("SKHDState.json")
        var configURL = URL(fileURLWithPath: ".skhdrc", relativeTo: .HomeDirectory)
        var version   = run("/usr/local/bin/skhd", "-v").stdout
        
        var float   = KeyboardShortcuts.getShortcut(for: .float)
        var bsp     = KeyboardShortcuts.getShortcut(for: .bsp)
        var stack   = KeyboardShortcuts.getShortcut(for: .stack)
        var focus   = KeyboardShortcuts.getShortcut(for: .focus)
        var resize  = KeyboardShortcuts.getShortcut(for: .resize)
        var move    = KeyboardShortcuts.getShortcut(for: .move)
        var gaps    = KeyboardShortcuts.getShortcut(for: .gaps)
        var padding = KeyboardShortcuts.getShortcut(for: .padding)
        var split   = KeyboardShortcuts.getShortcut(for: .split)
        var balance = KeyboardShortcuts.getShortcut(for: .balance)
    }
    enum Action: Equatable {
        case updateFloat(KeyboardShortcuts.Shortcut?)
        case updateBsp(KeyboardShortcuts.Shortcut?)
        case updateStack(KeyboardShortcuts.Shortcut?)
        case updateFocus(KeyboardShortcuts.Shortcut?)
        case updateResize(KeyboardShortcuts.Shortcut?)
        case updateMove(KeyboardShortcuts.Shortcut?)
        case updateGaps(KeyboardShortcuts.Shortcut?)
        case updatePadding(KeyboardShortcuts.Shortcut?)
        case updateSplit(KeyboardShortcuts.Shortcut?)
        case updateBalance(KeyboardShortcuts.Shortcut?)
            
    }
}

extension SKHD {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        

        case let .updateFloat(shortcut):
            state.float = shortcut
            return .none
            
        case let .updateBsp(shortcut):
            state.bsp = shortcut
            return .none
            
        case let .updateStack(shortcut):
            state.stack = shortcut
            return .none
            
        case let .updateFocus(shortcut):
            state.focus = shortcut
            return .none
            
        case let .updateResize(shortcut):
            state.resize = shortcut
            return .none
            
        case let .updateMove(shortcut):
            state.move = shortcut
            return .none
            
        case let .updateGaps(shortcut):
            state.gaps = shortcut
            return .none
            
        case let .updatePadding(shortcut):
            state.padding = shortcut
            return .none
            
        case let .updateSplit(shortcut):
            state.split = shortcut
            return .none
            
        case let .updateBalance(shortcut):
            state.balance = shortcut
            return .none
        }
    }
}


extension SKHD {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}

//MARK:- KEYBOARD SHORTCUTS

