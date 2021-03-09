//
//  KeyboardShortcutView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import KeyboardShortcuts

struct KBShortcut: View {
    let shortcut: KeyboardShortcuts.Name
    let action: ((KeyboardShortcuts.Shortcut?) -> Void)?
    
    init(_ shortcut: KeyboardShortcuts.Name,
         _ action: ((KeyboardShortcuts.Shortcut?) -> Void)?
    ) {
        self.shortcut = shortcut
        self.action = action
    }
    
    var body: some View {
        HStack {
            HStack {
                Text(shortcut.rawValue)
                Spacer()
            }
            .frame(width: 110)
            KeyboardShortcuts.Recorder(for: shortcut, onChange: action)
        }
    }
}



// MARK:- SwiftUI_Previews
struct KeyboardShortcutView_Previews: PreviewProvider {
    static var previews: some View {
        KBShortcut(.restartYabai) { _ in () }
    }
}
