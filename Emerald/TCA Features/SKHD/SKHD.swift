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
        var stateURL  = URL(fileURLWithPath: "SKHDState.json", relativeTo: .HomeDirectory)
        var configURL = URL(fileURLWithPath: ".skhdrc", relativeTo: .HomeDirectory)
        var version   = run("/usr/local/bin/skhd", "-v").stdout
        var isEnabled = true
    }
    enum Action: Equatable {
        case reset
        case setDefaults
        case toggleIsEnabled
    }
}

extension SKHD {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        case .reset:
            KeyboardShortcuts.reset(KeyboardShortcuts.Name.allCases)
            return .none
            
        case .setDefaults:
            KeyboardShortcuts.setShortcut(.init(.a, modifiers: [.command, .shift]), for: KeyboardShortcuts.Name.focusEast)
            return .none
            
        case .toggleIsEnabled:
            state.isEnabled.toggle()
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

func skhd(_ shortcut: KeyboardShortcuts.Shortcut?) -> String {
    shortcut?.description
        .compactMap { SKHDShortcutCharacter(rawValue: $0)?.configFile }
        .joined(separator: " + ") ?? "# UNASSIGNED"
}

