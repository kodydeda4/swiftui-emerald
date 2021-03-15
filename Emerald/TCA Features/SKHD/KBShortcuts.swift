//
//  KBShortcuts.swift
//  Emerald
//
//  Created by Kody Deda on 3/9/21.
//

import SwiftUI
import KeyboardShortcuts

struct KBShortcut: View {
    let shortcut: KeyboardShortcuts.Name
    
    init(for shortcut: KeyboardShortcuts.Name) {
        self.shortcut = shortcut
    }
    
    var body: some View {
        HStack {
            Text(shortcut.rawValue)
            KeyboardShortcuts.Recorder(for: shortcut, onChange: {
                if let kb = $0 {
                    let s = convertToString(kb)
                    print(s)
                }
            })
        }
    }
}

// MARK:- Events

func convertToString(_ shortcut: KeyboardShortcuts.Shortcut) -> String {
    [
        shortcut.modifiers.asStrings.joined(separator: " + "),
        shortcut.key?.asString,
    ]
    .compactMap({$0})
    .joined(separator: " + ")
}

extension NSEvent.ModifierFlags {
    public var asStrings: [String] {
        var rv: [String] = []
        
        if self.contains(.command) { rv.append("cmd") }
        if self.contains(.option)  { rv.append("option") }
        if self.contains(.control) { rv.append("cntrl") }
        if self.contains(.shift)   { rv.append("shift") }
        
        return rv
    }
}

extension KeyboardShortcuts.Key {
    public var asString: String? {
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

struct KBShortcut_Previews: PreviewProvider {
    static var previews: some View {
        KBShortcut(for: .toggleBSP)
    }
}
