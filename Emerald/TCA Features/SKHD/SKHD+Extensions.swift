//
//  SKHDConfigFile.swift
//  Emerald
//
//  Created by Kody Deda on 3/3/21.
//

import Foundation
import KeyboardShortcuts

import SwiftUI
import ComposableArchitecture

extension SKHD.State {
    var asConfig: String {
"""
#
#
#   ███████╗██╗  ██╗██╗  ██╗██████╗
#   ██╔════╝██║ ██╔╝██║  ██║██╔══██╗
#   ███████╗█████╔╝ ███████║██║  ██║
#   ╚════██║██╔═██╗ ██╔══██║██║  ██║
#   ███████║██║  ██╗██║  ██║██████╔╝
#   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝
#
#   ~/\(configURL.relativePath)
#   \(version)
#

.blacklist [\"YabaiUI\"]
            
#============================================
# Section A
#============================================
\(KeyboardShortcuts.getShortcut(for: .restartYabai)?.skhdString   ?? "#<UNASSIGNED>") : \"/bin/launchctl kickstart -k \"gui/${UID}/homebrew.mxcl.yabai\"
\(KeyboardShortcuts.getShortcut(for: .togglePadding)?.skhdString  ?? "#<UNASSIGNED>") : yabai -m space --toggle padding
\(KeyboardShortcuts.getShortcut(for: .toggleGaps)?.skhdString     ?? "#<UNASSIGNED>") : yabai -m space --toggle gap
\(KeyboardShortcuts.getShortcut(for: .toggleSplit)?.skhdString    ?? "#<UNASSIGNED>") : yabai -m window --toggle split
\(KeyboardShortcuts.getShortcut(for: .toggleBalance)?.skhdString  ?? "#<UNASSIGNED>") : yabai -m space --balance
\(KeyboardShortcuts.getShortcut(for: .toggleStacking)?.skhdString ?? "#<UNASSIGNED>") : yabai -m space --layout stack
\(KeyboardShortcuts.getShortcut(for: .toggleFloating)?.skhdString ?? "#<UNASSIGNED>") : yabai -m space --layout float
\(KeyboardShortcuts.getShortcut(for: .toggleBSP)?.skhdString      ?? "#<UNASSIGNED>") : yabai -m space --layout bsp

\(KeyboardShortcuts.getShortcut(for: .focusWest)?.skhdString      ?? "#<UNASSIGNED>") : yabai -m window --focus west
\(KeyboardShortcuts.getShortcut(for: .focusEast)?.skhdString      ?? "#<UNASSIGNED>") : yabai -m window --focus east
\(KeyboardShortcuts.getShortcut(for: .focusSouth)?.skhdString     ?? "#<UNASSIGNED>") : yabai -m window --focus south
\(KeyboardShortcuts.getShortcut(for: .focusNorth)?.skhdString     ?? "#<UNASSIGNED>") : yabai -m window --focus north

\(KeyboardShortcuts.getShortcut(for: .moveWest)?.skhdString       ?? "#<UNASSIGNED>") : yabai -m window --warp west
\(KeyboardShortcuts.getShortcut(for: .moveEast)?.skhdString       ?? "#<UNASSIGNED>") : yabai -m window --warp east
\(KeyboardShortcuts.getShortcut(for: .moveSouth)?.skhdString      ?? "#<UNASSIGNED>") : yabai -m window --warp south
\(KeyboardShortcuts.getShortcut(for: .moveNorth)?.skhdString      ?? "#<UNASSIGNED>") : yabai -m window --warp north

\(KeyboardShortcuts.getShortcut(for: .resizeTop)?.skhdString      ?? "#<UNASSIGNED>") : yabai -m window --resize top:0:-50   ; yabai -m window --resize bottom:0:-50
\(KeyboardShortcuts.getShortcut(for: .resizeLeft)?.skhdString     ?? "#<UNASSIGNED>") : yabai -m window --resize left:-50:0  ; yabai -m window --resize right:-50:0
\(KeyboardShortcuts.getShortcut(for: .resizeRight)?.skhdString    ?? "#<UNASSIGNED>") : yabai -m window --resize right:50:0  ; yabai -m window --resize left:50:0
\(KeyboardShortcuts.getShortcut(for: .resizeBottom)?.skhdString   ?? "#<UNASSIGNED>") : yabai -m window --resize bottom:0:50 ; yabai -m window --resize top:0:50
"""
    }
}



// MARK:- Parsing
extension KeyboardShortcuts.Shortcut {
    var skhdString: String {
        [
            modifiers.asStrings.joined(separator: " + "),
            key?.asString
        ]
        .compactMap({$0})
        .joined(separator: " - ")
    }
}

extension NSEvent.ModifierFlags {
    var asStrings: [String] {
        var rv: [String] = []
        
        if self.contains(.command) { rv.append("cmd") }
        if self.contains(.option)  { rv.append("alt") }
        if self.contains(.control) { rv.append("lctrl") }
        if self.contains(.shift)   { rv.append("shift") }
        
        return rv
    }
}

extension KeyboardShortcuts.Key {
    var asString: String? {
        switch self {
        
        // Letter
        case .a : return "a"
        case .b : return "b"
        case .c : return "c"
        case .d : return "d"
        case .e : return "e"
        case .f : return "f"
        case .g : return "g"
        case .h : return "h"
        case .i : return "i"
        case .j : return "j"
        case .k : return "k"
        case .l : return "l"
        case .m : return "m"
        case .n : return "n"
        case .o : return "o"
        case .p : return "p"
        case .q : return "q"
        case .r : return "r"
        case .s : return "s"
        case .t : return "t"
        case .u : return "u"
        case .v : return "v"
        case .w : return "w"
        case .x : return "x"
        case .y : return "y"
        case .z : return "z"
            
        // Number
        case .zero  : return "0"
        case .one   : return "1"
        case .two   : return "2"
        case .three : return "3"
        case .four  : return "4"
        case .five  : return "5"
        case .six   : return "6"
        case .seven : return "7"
        case .eight : return "8"
        case .nine  : return "9"
            
        // ArrowDirection
        case .upArrow    : return "up"
        case .downArrow  : return "down"
        case .leftArrow  : return "left"
        case .rightArrow : return "right"
            
        // fKey
        case .f1  : return "f1"
        case .f2  : return "f2"
        case .f3  : return "f3"
        case .f4  : return "f4"
        case .f5  : return "f5"
        case .f6  : return "f6"
        case .f7  : return "f7"
        case .f8  : return "f8"
        case .f9  : return "f9"
        case .f10 : return "f10"
        case .f11 : return "f11"
        case .f12 : return "f12"
            
        default:
            return nil
        }
    }
}

