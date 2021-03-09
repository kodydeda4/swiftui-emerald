//
//  SKHDSettings.swift
//  Emerald
//
//  Created by Kody Deda on 2/17/21.
//

import ComposableArchitecture
import KeyboardShortcuts
import SwiftShell

extension KeyboardShortcuts.Name {
    static let restartYabai   = Self("Restart Yabai")
    static let togglePadding  = Self("Toggle Padding")
    static let toggleGaps     = Self("Toggle Gaps")
    static let toggleSplit    = Self("Toggle Split")
    static let toggleBalance  = Self("Toggle Balance")
    static let toggleStacking = Self("Toggle Stacking")
    static let toggleFloating = Self("Toggle Floating")
    static let toggleBSP      = Self("Toggle BSP")
    
    
    static let allCases: [KeyboardShortcuts.Name] = [
        KeyboardShortcuts.Name.restartYabai,
        KeyboardShortcuts.Name.togglePadding,
        KeyboardShortcuts.Name.toggleGaps,
        KeyboardShortcuts.Name.toggleSplit,
        KeyboardShortcuts.Name.toggleBalance,
        KeyboardShortcuts.Name.toggleStacking,
        KeyboardShortcuts.Name.toggleFloating,
        KeyboardShortcuts.Name.toggleBSP,
    ]
}

struct SKHD {
    struct State: Equatable, Codable {
        var stateURL               = URL(fileURLWithPath: "SKHDState.json", relativeTo: .HomeDirectory)
        var configURL              = URL(fileURLWithPath: ".skhdrc", relativeTo: .HomeDirectory)
        var version                = run("/usr/local/bin/skhd", "-v").stdout
    }
    enum Action: Equatable {
        // action
    }
}

extension SKHD {
    static let reducer = Reducer<State, Action, Void>.combine(
//        Reducer { state, action, _ in
//            switch action {
//
//            }
//        }
    )
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

