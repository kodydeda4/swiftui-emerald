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
            KeyboardShortcuts.Recorder(for: shortcut)
        }
    }
}

struct KBShortcut_Previews: PreviewProvider {
    static var previews: some View {
        KBShortcut(for: .toggleBSP)
    }
}
