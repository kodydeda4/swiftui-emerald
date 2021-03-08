//
//  MyKeyboardShortcutsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import KeyboardShortcuts

struct MyKeyboardShortcutsView: View {
    let title: String
    let shortcut: KeyboardShortcuts.Name
    let action: ((KeyboardShortcuts.Shortcut?) -> Void)?
    
    init(_ title: String,
         _ shortcut: KeyboardShortcuts.Name,
         _ action: ((KeyboardShortcuts.Shortcut?) -> Void)?
    ) {
        self.title = title
        self.shortcut = shortcut
        self.action = action
    }
    
    var body: some View {
        HStack {
            HStack {
                Text(title)
                Spacer()
            }
            .frame(width: 110)
            KeyboardShortcuts.Recorder(for: shortcut, onChange: action)
        }
    }
}



// MARK:- SwiftUI_Previews
struct MyKeyboardShortcutsView_Previews: PreviewProvider {
    static var previews: some View {
        MyKeyboardShortcutsView("Restart Yabai", .restartYabai) { _ in () }
    }
}
