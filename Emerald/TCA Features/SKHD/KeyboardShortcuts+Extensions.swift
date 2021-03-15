//
//  KeyboardShortcuts+Extensions.swift
//  Emerald
//
//  Created by Kody Deda on 3/9/21.
//

import KeyboardShortcuts
import SwiftUI

extension KeyboardShortcuts.Name {
    static let restartYabai   = Self("Restart Yabai")
    
    static let togglePadding  = Self("Toggle Padding")
    static let toggleGaps     = Self("Toggle Gaps")
    static let toggleSplit    = Self("Toggle Split")
    static let toggleBalance  = Self("Toggle Balance")
    
    static let toggleStacking = Self("Stacking")
    static let toggleFloating = Self("Floating")
    static let toggleBSP      = Self("Tiling")
    
    static let focusWest      = Self("West")
    static let focusEast      = Self("East")
    static let focusSouth     = Self("South")
    static let focusNorth     = Self("North")
    
    static let moveWest       = Self("West")
    static let moveEast       = Self("East")
    static let moveSouth      = Self("South")
    static let moveNorth      = Self("North")
    
    static let resizeTop      = Self("Top")
    static let resizeLeft     = Self("Left")
    static let resizeRight    = Self("Right")
    static let resizeBottom   = Self("Bottom")
        
    static let allCases: [KeyboardShortcuts.Name] = [
        .restartYabai,
        .togglePadding,
        .toggleGaps,
        .toggleSplit,
        .toggleBalance,
        .toggleStacking,
        .toggleFloating,
        .toggleBSP,
        .focusWest,
        .focusEast,
        .focusSouth,
        .focusNorth,
        .moveWest,
        .moveEast,
        .moveSouth,
        .moveNorth,
        .resizeTop,
        .resizeLeft,
        .resizeRight,
        .resizeBottom,
    ]
}

extension KeyboardShortcuts {
    static func set(_ shortcut: KeyboardShortcuts.Name, _ modifiers: NSEvent.ModifierFlags, _ key: KeyboardShortcuts.Key) {
        KeyboardShortcuts.setShortcut(
            KeyboardShortcuts.Shortcut(
                key,
                modifiers: modifiers
            ),
            for: shortcut
        )

    }
}
