//
//  SKHDSettings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/17/21.
//

import ComposableArchitecture
import KeyboardShortcuts

//  https://github.com/sindresorhus/KeyboardShortcuts


//MARK:-  restartYabai
//        launchctl kickstart -k "gui/${UID}/homebrew.mxcl.yabai"

extension KeyboardShortcuts.Name {
    static let restartYabai    = Self("restartYabai")
    static let togglePadding  = Self("togglePadding")
    static let toggleGaps     = Self("toggleGaps")
    static let toggleSplit    = Self("toggleSplit")
    static let toggleBalance  = Self("toggleBalance")
    static let toggleStacking = Self("toggleStacking")
    static let toggleFloating = Self("toggleFloating")
    static let toggleBSP      = Self("toggleBSP")
}

struct SKHDSettings {
    struct State: Equatable, Codable {
        var restartYabai           = KeyboardShortcuts.getShortcut(for: .restartYabai)
        var togglePaddingShortcut  = KeyboardShortcuts.getShortcut(for: .togglePadding)
        var toggleGapsShortcut     = KeyboardShortcuts.getShortcut(for: .toggleGaps)
        var toggleSplitShortcut    = KeyboardShortcuts.getShortcut(for: .toggleSplit)
        var toggleBalanceShortcut  = KeyboardShortcuts.getShortcut(for: .toggleBalance)
        var toggleStackingShortcut = KeyboardShortcuts.getShortcut(for: .toggleStacking)
        var toggleFloatingShortcut = KeyboardShortcuts.getShortcut(for: .toggleFloating)
        var toggleBSPShortcut      = KeyboardShortcuts.getShortcut(for: .toggleBSP)

        var myText: String = "Nothin"

    }
    enum Action: Equatable {
        case updateRestartYabai(KeyboardShortcuts.Shortcut?)
        case updateTogglePadding(KeyboardShortcuts.Shortcut?)
        case updateToggleGaps(KeyboardShortcuts.Shortcut?)
        case updateToggleSplit(KeyboardShortcuts.Shortcut?)
        case updateToggleBalance(KeyboardShortcuts.Shortcut?)
        case updateToggleStacking(KeyboardShortcuts.Shortcut?)
        case updateToggleFloating(KeyboardShortcuts.Shortcut?)
        case updateToggleBSP(KeyboardShortcuts.Shortcut?)
        case keyPath(BindingAction<SKHDSettings.State>)
    }
}

extension SKHDSettings {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        case .keyPath:
            return .none
            
        case let .updateRestartYabai(shortcut):
            state.restartYabai = shortcut
            return .none
            
        case let .updateTogglePadding(shortcut):
            state.togglePaddingShortcut = shortcut
            return .none
            
        case let .updateToggleGaps(shortcut):
            state.toggleGapsShortcut = shortcut
            return .none
            
        case let .updateToggleSplit(shortcut):
            state.toggleSplitShortcut = shortcut
            return .none

        case let .updateToggleBalance(shortcut):
            state.toggleBalanceShortcut = shortcut
            return .none

        case let .updateToggleStacking(shortcut):
            state.toggleStackingShortcut = shortcut
            return .none

        case let .updateToggleFloating(shortcut):
            state.toggleFloatingShortcut = shortcut
            return .none

        case let .updateToggleBSP(shortcut):
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

func skhd(_ shortcut: KeyboardShortcuts.Shortcut?) -> String {
    shortcut?.description
        .compactMap { SKHDShortcutCharacter(rawValue: $0)!.configFile }
        .joined(separator: " + ") ?? "# UNASSIGNED"
}

extension SKHDSettings.State {
    var asConfig: String {
        [
            "# SKHD Config",
            ".blacklist [\"YabaiUI\"]",
            "",
            "#======================================================",
            "# Section A",
            "#======================================================",
            "",
            "\(skhd(restartYabai)) \"/bin/launchctl kickstart -k \"gui/${UID}/homebrew.mxcl.yabai\"",
            "\(skhd(togglePaddingShortcut)) : yabai -m space --toggle padding",
            "\(skhd(toggleGapsShortcut)) : yabai -m space --toggle gap",
            "\(skhd(toggleSplitShortcut)) : yabai -m window --toggle split",
            "\(skhd(toggleBalanceShortcut)) : yabai -m space --balance",
            "\(skhd(toggleStackingShortcut)) : yabai -m space --layout stack",
            "\(skhd(toggleFloatingShortcut)) : yabai -m space --layout float",
            "\(skhd(toggleBSPShortcut)) : yabai -m space --layout bsp",
        ]
        .joined(separator: "\n")
    }
}


