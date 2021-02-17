//
//  SKHDSettings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/17/21.
//

import SwiftUI
import ComposableArchitecture
import KeyboardShortcuts

//  https://github.com/sindresorhus/KeyboardShortcuts
extension KeyboardShortcuts.Name {
    static let togglePaddingShortcut  = Self("togglePaddingShortcut")
    static let toggleSplitShortcut    = Self("toggleSplitShortcut")
    static let toggleBalanceShortcut  = Self("toggleBalanceShortcut")
    static let toggleStackingShortcut = Self("toggleStackingShortcut")
    static let toggleFloatingShortcut = Self("toggleFloatingShortcut")
    static let toggleBSPShortcut      = Self("toggleBSPShortcut")
}

struct SKHDSettings {
    struct State: Equatable, Codable {
        var togglePaddingShortcut  = KeyboardShortcuts.getShortcut(for: .togglePaddingShortcut)
        var toggleSplitShortcut    = KeyboardShortcuts.getShortcut(for: .toggleSplitShortcut)
        var toggleBalanceShortcut  = KeyboardShortcuts.getShortcut(for: .toggleBalanceShortcut)
        var toggleStackingShortcut = KeyboardShortcuts.getShortcut(for: .toggleStackingShortcut)
        var toggleFloatingShortcut = KeyboardShortcuts.getShortcut(for: .toggleFloatingShortcut)
        var toggleBSPShortcut      = KeyboardShortcuts.getShortcut(for: .toggleBSPShortcut)

        var myText: String = "Nothin"

    }
    enum Action: Equatable {
        case updateTogglePaddingShortcut(KeyboardShortcuts.Shortcut?)
        case updateToggleSplitShortcut(KeyboardShortcuts.Shortcut?)
        case updateToggleBalanceShortcut(KeyboardShortcuts.Shortcut?)
        case updateToggleStackingShortcut(KeyboardShortcuts.Shortcut?)
        case updateToggleFloatingShortcut(KeyboardShortcuts.Shortcut?)
        case updateToggleBSPShortcut(KeyboardShortcuts.Shortcut?)
        case keyPath(BindingAction<SKHDSettings.State>)
    }
}

extension SKHDSettings {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        case .keyPath:
            return .none
            
        case let .updateTogglePaddingShortcut(shortcut):
            state.togglePaddingShortcut = shortcut
            return .none
            
        case let .updateToggleSplitShortcut(shortcut):
            state.toggleSplitShortcut = shortcut
            return .none

        case let .updateToggleBalanceShortcut(shortcut):
            state.toggleBalanceShortcut = shortcut
            return .none

        case let .updateToggleStackingShortcut(shortcut):
            state.toggleStackingShortcut = shortcut
            return .none

        case let .updateToggleFloatingShortcut(shortcut):
            state.toggleFloatingShortcut = shortcut
            return .none

        case let .updateToggleBSPShortcut(shortcut):
            state.toggleBSPShortcut = shortcut
            return .none

        }
    }
    .binding(action: /Action.keyPath)
}

extension SKHDSettings {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}

enum SKHDShortcuts: Character {
    case shift   = "⇧"
    case control = "⌃"
    case option  = "⌥"
    case command = "⌘"
    
    var configFile: String {
        switch self {
        
        case .shift:
            return "shift"
        case .control:
            return "lctrl"
        case .option:
            return "alt"
        case .command:
            return "cmd"
        }
    }
}

extension SKHDSettings.State {
    var asConfig: String {
        
        [
            "\((togglePaddingShortcut?.description ?? "UNASSIGNED").compactMap{ SKHDShortcuts(rawValue: $0)?.configFile}.joined(separator: " + ")) : yabai -m space --toggle padding; yabai -m space --toggle gap",
//            "\(togglePaddingShortcut?.description  ?? "UNNASSIGNED") : yabai -m space --toggle padding; yabai -m space --toggle gap",
//            "\(toggleSplitShortcut?.description    ?? "UNNASSIGNED") : yabai -m window --toggle split",
//            "\(toggleBalanceShortcut?.description  ?? "UNNASSIGNED") : yabai -m space --balance",
//            "\(toggleStackingShortcut?.description ?? "UNNASSIGNED") : yabai -m space --layout stack",
//            "\(toggleFloatingShortcut?.description ?? "UNNASSIGNED") : yabai -m space --layout float",
//            "\(toggleBSPShortcut?.description      ?? "UNNASSIGNED") : yabai -m space --layout bsp",
        ]
        .filter { !$0.contains("UNNASSIGNED") }
        .joined(separator: "\n")
    }
}
