//
//  SKHDSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 2/17/21.
//

import SwiftUI
import ComposableArchitecture
import KeyboardShortcuts

struct SKHDSettingsView: View {
    let store: Store<SKHD.State, SKHD.Action>
    let keyPath = SKHD.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                DebugConfigFileView(text: viewStore.asConfig)
                
                List {
                    SectionView("Section A") {
                        SpecialKeyboardShortcutView("Restart Yabai",   .restartYabai)   { viewStore.send(.updateRestartYabai(  $0)) }
                        SpecialKeyboardShortcutView("Toggle Padding",  .togglePadding)  { viewStore.send(.updateTogglePadding( $0)) }
                        SpecialKeyboardShortcutView("Toggle Gaps",     .toggleGaps)     { viewStore.send(.updateToggleGaps(    $0)) }
                        SpecialKeyboardShortcutView("Toggle Split",    .toggleSplit)    { viewStore.send(.updateToggleSplit(   $0)) }
                        SpecialKeyboardShortcutView("Toggle Balance",  .toggleBalance)  { viewStore.send(.updateToggleBalance( $0)) }
                        SpecialKeyboardShortcutView("Toggle Stacking", .toggleStacking) { viewStore.send(.updateToggleStacking($0)) }
                        SpecialKeyboardShortcutView("Toggle Floating", .toggleFloating) { viewStore.send(.updateToggleFloating($0)) }
                        SpecialKeyboardShortcutView("Toggle BSP",      .toggleBSP)      { viewStore.send(.updateToggleBSP(     $0)) }
                    }
                }
            }
            .navigationTitle("Debug SKHD")
        }
    }
}

struct SKHDSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SKHDSettingsView(store: SKHD.defaultStore)
    }
}

// MARK:- SpecialKeyboardShortcutView

private struct SpecialKeyboardShortcutView: View {
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

struct SpecialKeyboardShortcutView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialKeyboardShortcutView("Restart Yabai", .restartYabai) { _ in () }
    }
}
