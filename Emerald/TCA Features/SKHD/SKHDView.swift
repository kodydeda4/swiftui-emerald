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
    let k = SKHD.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            HStack {
                DebugConfigFileView(text: vs.asConfig)
                
                List {
                    SectionView("Section A") {
                        MyKeyboardShortcutsView("Restart Yabai",   .restartYabai)   { vs.send(.updateRestartYabai(  $0)) }
                        MyKeyboardShortcutsView("Toggle Padding",  .togglePadding)  { vs.send(.updateTogglePadding( $0)) }
                        MyKeyboardShortcutsView("Toggle Gaps",     .toggleGaps)     { vs.send(.updateToggleGaps(    $0)) }
                        MyKeyboardShortcutsView("Toggle Split",    .toggleSplit)    { vs.send(.updateToggleSplit(   $0)) }
                        MyKeyboardShortcutsView("Toggle Balance",  .toggleBalance)  { vs.send(.updateToggleBalance( $0)) }
                        MyKeyboardShortcutsView("Toggle Stacking", .toggleStacking) { vs.send(.updateToggleStacking($0)) }
                        MyKeyboardShortcutsView("Toggle Floating", .toggleFloating) { vs.send(.updateToggleFloating($0)) }
                        MyKeyboardShortcutsView("Toggle BSP",      .toggleBSP)      { vs.send(.updateToggleBSP(     $0)) }
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

