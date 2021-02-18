//
//  SKHDSettings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/17/21.
//

import ComposableArchitecture
import KeyboardShortcuts

//  https://github.com/sindresorhus/KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let togglePaddingShortcut  = Self("togglePaddingShortcut")
    static let toggleGapsShortcut     = Self("toggleGapsShortcut")
    static let toggleSplitShortcut    = Self("toggleSplitShortcut")
    static let toggleBalanceShortcut  = Self("toggleBalanceShortcut")
    static let toggleStackingShortcut = Self("toggleStackingShortcut")
    static let toggleFloatingShortcut = Self("toggleFloatingShortcut")
    static let toggleBSPShortcut      = Self("toggleBSPShortcut")
}

struct SKHDSettings {
    struct State: Equatable, Codable {
        var togglePaddingShortcut  = KeyboardShortcuts.getShortcut(for: .togglePaddingShortcut)
        var toggleGapsShortcut     = KeyboardShortcuts.getShortcut(for: .toggleGapsShortcut)
        var toggleSplitShortcut    = KeyboardShortcuts.getShortcut(for: .toggleSplitShortcut)
        var toggleBalanceShortcut  = KeyboardShortcuts.getShortcut(for: .toggleBalanceShortcut)
        var toggleStackingShortcut = KeyboardShortcuts.getShortcut(for: .toggleStackingShortcut)
        var toggleFloatingShortcut = KeyboardShortcuts.getShortcut(for: .toggleFloatingShortcut)
        var toggleBSPShortcut      = KeyboardShortcuts.getShortcut(for: .toggleBSPShortcut)

        var myText: String = "Nothin"

    }
    enum Action: Equatable {
        case updateTogglePaddingShortcut(KeyboardShortcuts.Shortcut?)
        case updateToggleGapsShortcut(KeyboardShortcuts.Shortcut?)
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
            
        case let .updateToggleGapsShortcut(shortcut):
            state.toggleGapsShortcut = shortcut
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

func skhd(_ shortcut: KeyboardShortcuts.Shortcut?) -> String {
    shortcut?.description
        .compactMap { SKHDShortcuts(rawValue: $0)!.configFile }
        .joined(separator: " + ") ?? "# UNASSIGNED"
}

extension SKHDSettings.State {
    var asConfig: String {
        [
            "# SKHD Config",
            
            "\n# = Misc ===================================\n",
            
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

