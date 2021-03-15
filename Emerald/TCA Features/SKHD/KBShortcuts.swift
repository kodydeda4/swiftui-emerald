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
    
    let acceptedModifiers: NSEvent.ModifierFlags = [
        .command,
        .option,
        .control,
        .shift
    ]
    
    var acceptedKeys: [KeyboardShortcuts.Key] {
        let letters: [KeyboardShortcuts.Key] = [
            .a, .b, .c, .d, .e, .f, .g,
            .h, .i, .j, .k, .l, .m, .n, .o, .p,
            .q, .r, .s, .t, .u, .v,
            .w, .x, .y, .z,
        ]
        
        let numbers: [KeyboardShortcuts.Key] = [
            .zero,
            .one, .two, .three,
            .four, .five, .six,
            .seven, .eight, .nine
        ]
        
        let arrows: [KeyboardShortcuts.Key] = [
            .upArrow, .downArrow,
            .leftArrow, .rightArrow,
        ]
        
        let fKeys: [KeyboardShortcuts.Key] = [
            .f1, .f2, .f3,
            .f4, .f5, .f6,
            .f7, .f8, .f9,
            .f10, .f11, .f12,
        ]

        return []
            + letters
            + numbers
            + arrows
            + fKeys
    }

    init(for shortcut: KeyboardShortcuts.Name) {
        self.shortcut = shortcut
    }
    
    var body: some View {
        HStack {
            Text(shortcut.rawValue)
            KeyboardShortcuts.Recorder(for: shortcut, onChange: {
                s in
                if let x = s {
                    
//                    if x.key == KeyboardShortcuts.Key.a {
//                        print("A")
//                    }
                    
//                    if x.modifiers.isSubset(of: acceptedModifiers) {
//                        print("Cool (mods)")
//                    } else {
//                        print("Nah (mods)")
//                    }
                    
                    if acceptedKeys.contains(x.key!) {
                        print("Cool (key)")
                    } else {
                        print("Nah (key)")
                    }
                    print("\(acceptedModifiers) | \(x.modifiers) \(x.modifiers.isSubset(of: acceptedModifiers))")
                    
                    print("--------")
                    
                    if x.modifiers.isSubset(of: acceptedModifiers) && acceptedKeys.contains(x.key!) {
                        print("Pass")
                    } else {
                        print("Fail")
                    }
                }
            })
        }
    }
}

struct KBShortcut_Previews: PreviewProvider {
    static var previews: some View {
        KBShortcut(for: .toggleBSP)
    }
}
