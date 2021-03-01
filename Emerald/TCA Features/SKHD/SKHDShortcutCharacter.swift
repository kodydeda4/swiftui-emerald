//
//  SKHDShortcutCharacter.swift
//  Emerald
//
//  Created by Kody Deda on 2/18/21.
//

import Foundation

enum SKHDShortcutCharacter: Character {
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
}

extension SKHDShortcutCharacter {
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

