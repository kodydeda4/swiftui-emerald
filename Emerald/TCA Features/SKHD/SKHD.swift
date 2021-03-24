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
    }
    enum Action: Equatable {
        case reset
        case setDefaults
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
