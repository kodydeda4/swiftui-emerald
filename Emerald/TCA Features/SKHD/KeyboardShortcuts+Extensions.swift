//
//  KeyboardShortcuts+Extensions.swift
//  Emerald
//
//  Created by Kody Deda on 3/9/21.
//

import KeyboardShortcuts
import SwiftUI

extension KeyboardShortcuts.Name {
    static let float          = Self("Normal")
    static let bsp            = Self("Tiling")
    static let stack          = Self("Stacking")
    
    //----------------------------------------
    static let focus          = Self("Focus")
    static let resize         = Self("Resize")
    static let move           = Self("Move")
    //----------------------------------------
    
    static let restartYabai   = Self("Restart Yabai")
    
    static let gaps           = Self("Gaps")
    static let padding        = Self("Padding")
    
    static let split          = Self("Split")
    static let balance        = Self("Balance")

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
        .padding,
        .gaps,
        .split,
        .balance,
        
        .float,
        .bsp,
        .stack,
        
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
