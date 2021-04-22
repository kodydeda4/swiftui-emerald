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
    static let float          = Self("Normal")
    static let bsp            = Self("Tiling")
    static let stack          = Self("Stacking")
    static let focus          = Self("Focus")
    static let resize         = Self("Resize")
    static let move           = Self("Move")
    static let gaps           = Self("Gaps")
    static let padding        = Self("Padding")
    static let split          = Self("Split")
    static let balance        = Self("Balance")
}

struct SKHD {
    struct State: Equatable, Codable {
        var stateURL  = URL(fileURLWithPath: "SKHDState.json", relativeTo: .HomeDirectory)
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

import KeyboardShortcuts
import SwiftUI



extension KeyboardShortcuts {
    static func resetEmeraldDefaults() {
        KeyboardShortcuts.set(.float,          [.control, .option,          ], .one)
        KeyboardShortcuts.set(.bsp,            [.control, .option,          ], .two)
        KeyboardShortcuts.set(.stack,          [.control, .option,          ], .three)
        KeyboardShortcuts.set(.focus,          [.control,                   ], .help)
        KeyboardShortcuts.set(.resize,         [.control, .option,          ], .help)
        KeyboardShortcuts.set(.move,           [.control, .option, .command ], .help)
        KeyboardShortcuts.set(.gaps,           [.control, .option,          ], .g)
        KeyboardShortcuts.set(.padding,        [.control, .option,          ], .h)
        KeyboardShortcuts.set(.split,          [.control, .option,          ], .x)
        KeyboardShortcuts.set(.balance,        [.control, .option,          ], .b)
    }
}

extension KeyboardShortcuts {
    static func set(
        _ shortcut: KeyboardShortcuts.Name,
        _ modifiers: NSEvent.ModifierFlags,
        _ key: KeyboardShortcuts.Key
    ) {
        KeyboardShortcuts.setShortcut(
            KeyboardShortcuts.Shortcut(
                key,
                modifiers: modifiers
            ),
            for: shortcut
        )
    }
}

// MARK:- Old SKHD

//import ComposableArchitecture
//import KeyboardShortcuts
//import SwiftShell
//1
//extension KeyboardShortcuts.Name {
//    static let restartYabai   = Self("restartYabai")
//    static let togglePadding  = Self("togglePadding")
//    static let toggleGaps     = Self("toggleGaps")
//    static let toggleSplit    = Self("toggleSplit")
//    static let toggleBalance  = Self("toggleBalance")
//    static let toggleStacking = Self("toggleStacking")
//    static let toggleFloating = Self("toggleFloating")
//    static let toggleBSP      = Self("toggleBSP")
//}
//
//struct SKHD {
//    struct State: Equatable, Codable {
//        var stateURL               = URL(fileURLWithPath: "SKHDState.json", relativeTo: .HomeDirectory)
//        var configURL              = URL(fileURLWithPath: ".skhdrc", relativeTo: .HomeDirectory)
//        var version                = run("/usr/local/bin/skhd", "-v").stdout
//        var restartYabai           = KeyboardShortcuts.getShortcut(for: .restartYabai)
//        var togglePaddingShortcut  = KeyboardShortcuts.getShortcut(for: .togglePadding)
//        var toggleGapsShortcut     = KeyboardShortcuts.getShortcut(for: .toggleGaps)
//        var toggleSplitShortcut    = KeyboardShortcuts.getShortcut(for: .toggleSplit)
//        var toggleBalanceShortcut  = KeyboardShortcuts.getShortcut(for: .toggleBalance)
//        var toggleStackingShortcut = KeyboardShortcuts.getShortcut(for: .toggleStacking)
//        var toggleFloatingShortcut = KeyboardShortcuts.getShortcut(for: .toggleFloating)
//        var toggleBSPShortcut      = KeyboardShortcuts.getShortcut(for: .toggleBSP)
//    }
//    enum Action: Equatable {
//        case updateRestartYabai(KeyboardShortcuts.Shortcut?)
//        case updateTogglePadding(KeyboardShortcuts.Shortcut?)
//        case updateToggleGaps(KeyboardShortcuts.Shortcut?)
//        case updateToggleSplit(KeyboardShortcuts.Shortcut?)
//        case updateToggleBalance(KeyboardShortcuts.Shortcut?)
//        case updateToggleStacking(KeyboardShortcuts.Shortcut?)
//        case updateToggleFloating(KeyboardShortcuts.Shortcut?)
//        case updateToggleBSP(KeyboardShortcuts.Shortcut?)
//        case keyPath(BindingAction<SKHD.State>)
//    }
//}
//
//extension SKHD {
//    static let reducer = Reducer<State, Action, Void> {
//        state, action, _ in
//        switch action {
//        case .keyPath:
//            return .none
//
//        case let .updateRestartYabai(shortcut):
//            state.restartYabai = shortcut
//            return .none
//
//        case let .updateTogglePadding(shortcut):
//            state.togglePaddingShortcut = shortcut
//            return .none
//
//        case let .updateToggleGaps(shortcut):
//            state.toggleGapsShortcut = shortcut
//            return .none
//
//        case let .updateToggleSplit(shortcut):
//            state.toggleSplitShortcut = shortcut
//            return .none
//
//        case let .updateToggleBalance(shortcut):
//            state.toggleBalanceShortcut = shortcut
//            return .none
//
//        case let .updateToggleStacking(shortcut):
//            state.toggleStackingShortcut = shortcut
//            return .none
//
//        case let .updateToggleFloating(shortcut):
//            state.toggleFloatingShortcut = shortcut
//            return .none
//
//        case let .updateToggleBSP(shortcut):
//            state.toggleBSPShortcut = shortcut
//            return .none
//
//        }
//    }
//    .binding(action: /Action.keyPath)
//}
//
//extension SKHD {
//    static let defaultStore = Store(
//        initialState: .init(),
//        reducer: reducer,
//        environment: ()
//    )
//}
//
//func skhd(_ shortcut: KeyboardShortcuts.Shortcut?) -> String {
//    shortcut?.description
//        .compactMap { SKHDShortcutCharacter(rawValue: $0)!.configFile }
//        .joined(separator: " + ") ?? "# UNASSIGNED"
//}
//
