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
    static let restartYabai           = Self("restartYabai")
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
        .compactMap { SKHDShortcuts(rawValue: $0)!.configFile }
        .joined(separator: " + ") ?? "# UNASSIGNED"
}

extension SKHDSettings.State {
    var asConfig: String {
        [
            "# SKHD Config",
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




enum SKHDShortcuts: Character {
    case shift   = "⇧"
    case control = "⌃"
    case option  = "⌥"
    case command = "⌘"
    case up      = "↑"
    case down    = "↓"
    case left    = "←"
    case right   = "→"
    
    case a       = "A"
    case b       = "B"
    case c       = "C"
    case d       = "D"
    case e       = "E"
    case f       = "F"
    case g       = "G"
    case h       = "H"
    case i       = "I"
    case j       = "J"
    case k       = "K"
    case l       = "L"
    case m       = "M"
    case n       = "N"
    case o       = "O"
    case p       = "P"
    case q       = "Q"
    case r       = "R"
    case s       = "S"
    case t       = "T"
    case u       = "U"
    case v       = "V"
    case w       = "W"
    case x       = "X"
    case y       = "Y"
    case z       = "Z"
    
    case zero    = "0"
    case one     = "1"
    case two     = "2"
    case three   = "3"
    case four    = "4"
    case five    = "5"
    case six     = "6"
    case seven   = "7"
    case eight   = "8"
    case nine    = "9"
    
    var configFile: String {
        
        switch self {
        
        case .shift   : return "shift"
        case .control : return "lctrl"
        case .option  : return "alt"
        case .command : return "cmd"
        case .up      : return "up"
        case .down    : return "down"
        case .left    : return "left"
        case .right   : return "right"
        
        case .a       : return "A"
        case .b       : return "B"
        case .c       : return "C"
        case .d       : return "D"
        case .e       : return "E"
        case .f       : return "F"
        case .g       : return "G"
        case .h       : return "H"
        case .i       : return "I"
        case .j       : return "J"
        case .k       : return "K"
        case .l       : return "L"
        case .m       : return "M"
        case .n       : return "N"
        case .o       : return "O"
        case .p       : return "P"
        case .q       : return "Q"
        case .r       : return "R"
        case .s       : return "S"
        case .t       : return "T"
        case .u       : return "U"
        case .v       : return "V"
        case .w       : return "W"
        case .x       : return "X"
        case .y       : return "Y"
        case .z       : return "Z"
            
        case .zero    : return "0"
        case .one     : return "1"
        case .two     : return "2"
        case .three   : return "3"
        case .four    : return "4"
        case .five    : return "5"
        case .six     : return "6"
        case .seven   : return "7"
        case .eight   : return "8"
        case .nine    : return "9"
        }
    }
}

