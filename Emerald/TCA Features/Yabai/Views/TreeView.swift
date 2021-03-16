//
//  TreeView.swift
//  Emerald
//
//  Created by Kody Deda on 3/15/21.
//

import SwiftUI
import KeyboardShortcuts

struct TreeView: View {
    var northInt: KeyboardShortcuts.Name
    var southInt: KeyboardShortcuts.Name
    var eastInt:  KeyboardShortcuts.Name
    var westInt:  KeyboardShortcuts.Name
    
    let v: CGFloat = 100
    let o: Double = 1
    
    var body: some View {
        VStack {
            HStack {
                Rectangle().foregroundColor(.gray).frame(width: v, height: v).opacity(o)
                VKBShortcut(for: northInt).frame(width: v, height: v)
                Rectangle().foregroundColor(.gray).frame(width: v, height: v).opacity(o)

            }
            HStack {
                VKBShortcut(for: westInt).frame(width: v, height: v)
                Rectangle().foregroundColor(.gray).frame(width: v, height: v).opacity(o)
                VKBShortcut(for: eastInt).frame(width: v, height: v)

            }
            HStack {
                Rectangle().foregroundColor(.gray).frame(width: v, height: v).opacity(o)
                VKBShortcut(for: southInt).frame(width: v, height: v)
                Rectangle().foregroundColor(.gray).frame(width: v, height: v).opacity(o)
            }
        }
    }
}

struct TreeView_Previews: PreviewProvider {
    static var previews: some View {
        TreeView(
            northInt: KeyboardShortcuts.Name.focusNorth,
            southInt: KeyboardShortcuts.Name.focusSouth,
            eastInt:  KeyboardShortcuts.Name.focusEast,
            westInt:  KeyboardShortcuts.Name.focusWest
        )
    }
}

struct VKBShortcut: View {
    let shortcut: KeyboardShortcuts.Name
    
    init(for shortcut: KeyboardShortcuts.Name) {
        self.shortcut = shortcut
    }
    
    var body: some View {
        VStack {
            Text(shortcut.rawValue.first?.uppercased() ?? "")
            KeyboardShortcuts.Recorder(for: shortcut, onChange: {
                if let kb = $0 {
                    print(kb.skhdString)
                }
            })
        }
    }
}


struct VKBShortcut_Previews: PreviewProvider {
    static var previews: some View {
        VKBShortcut(for: .toggleBSP)
    }
}
