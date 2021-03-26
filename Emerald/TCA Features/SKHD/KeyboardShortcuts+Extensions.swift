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
        
    static let gaps           = Self("Gaps")
    static let padding        = Self("Padding")
    
    static let split          = Self("Split")
    static let balance        = Self("Balance")
}

extension KeyboardShortcuts {
    static func resetEmeraldDefaults() {
        KeyboardShortcuts.set(.gaps,           [.control, .option,          ], .g)
        KeyboardShortcuts.set(.padding,        [.control, .option,          ], .h)
        KeyboardShortcuts.set(.split,          [.control, .option,          ], .x)
        KeyboardShortcuts.set(.balance,        [.control, .option,          ], .b)
        KeyboardShortcuts.set(.float,          [.control, .option,          ], .one)
        KeyboardShortcuts.set(.bsp,            [.control, .option,          ], .two)
        KeyboardShortcuts.set(.stack,          [.control, .option,          ], .three)
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
