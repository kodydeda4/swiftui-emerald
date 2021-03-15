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
    
    static let focusWest      = Self("Focus West")
    static let focusEast      = Self("Focus East")
    static let focusSouth     = Self("Focus South")
    static let focusNorth     = Self("Focus North")
    
    static let moveWest       = Self("Move West")
    static let moveEast       = Self("Move East")
    static let moveSouth      = Self("Move South")
    static let moveNorth      = Self("Move North")
    
    static let resizeTop      = Self("Resize Top")
    static let resizeLeft     = Self("Resize Left")
    static let resizeRight    = Self("Resize Right")
    static let resizeBottom   = Self("Resize Bottom")
    
    
    
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

