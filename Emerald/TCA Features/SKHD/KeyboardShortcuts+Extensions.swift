//
//  KeyboardShortcuts+Extensions.swift
//  Emerald
//
//  Created by Kody Deda on 4/22/21.
//

import SwiftUI
import KeyboardShortcuts

extension KeyboardShortcuts.Name {
  static let float   = Self("Normal")
  static let bsp     = Self("Tiling")
  static let stack   = Self("Stacking")
  static let focus   = Self("Focus")
  static let resize  = Self("Resize")
  static let move    = Self("Move")
  static let gaps    = Self("Gaps")
  static let padding = Self("Padding")
  static let split   = Self("Split")
  static let balance = Self("Balance")
}

extension KeyboardShortcuts {
  static func resetEmeraldDefaults() {
    KeyboardShortcuts.set(.float,   [.control, .option,          ], .one)
    KeyboardShortcuts.set(.bsp,     [.control, .option,          ], .two)
    KeyboardShortcuts.set(.stack,   [.control, .option,          ], .three)
    KeyboardShortcuts.set(.focus,   [.control,                   ], .help)
    KeyboardShortcuts.set(.resize,  [.control, .option,          ], .help)
    KeyboardShortcuts.set(.move,    [.control, .option, .command ], .help)
    //KeyboardShortcuts.set(.gaps,    [.control, .option,          ], .g)
    //KeyboardShortcuts.set(.padding, [.control, .option,          ], .h)
    KeyboardShortcuts.set(.padding, [.control, .option,          ], .g)
    KeyboardShortcuts.set(.split,   [.control, .option,          ], .x)
    KeyboardShortcuts.set(.balance, [.control, .option,          ], .b)
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
