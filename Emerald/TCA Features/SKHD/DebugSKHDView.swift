//
//  SKHDSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 2/17/21.
//

import SwiftUI
import ComposableArchitecture
import KeyboardShortcuts

struct DebugSKHDSettingsView: View {
    let store: Store<SKHD.State, SKHD.Action>
    
    var body: some View {
        WithViewStore(store) { vs in
            HStack {
                DebugConfigFileView(text: vs.asConfig)
                
                VStack {
                    Text("Click Apply Changes to refresh Config")
                    KBShortcut(for: .restartYabai)
                    KBShortcut(for: .togglePadding)
                    KBShortcut(for: .toggleGaps)
                    KBShortcut(for: .toggleSplit)
                    KBShortcut(for: .toggleBalance)
                    KBShortcut(for: .toggleStacking)
                    KBShortcut(for: .toggleFloating)
                    KBShortcut(for: .toggleBSP)
                }
            }
            .navigationTitle("Debug SKHD")
        }
    }
}

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

struct SKHDSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DebugSKHDSettingsView(store: SKHD.defaultStore)
    }
}

