//
//  KeyboardShortcuts+Extensions.swift
//  Emerald
//
//  Created by Kody Deda on 3/9/21.
//

import KeyboardShortcuts

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
