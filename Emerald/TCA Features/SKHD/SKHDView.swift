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
                        KeyboardShortcutView(.restartYabai) {
                            vs.send(.updateRestartYabai($0))
                        }
                        KeyboardShortcutView(.togglePadding) {
                            vs.send(.updateTogglePadding($0))
                        }
                        KeyboardShortcutView(.toggleGaps) {
                            vs.send(.updateToggleGaps($0))
                        }
                        KeyboardShortcutView(.toggleSplit) {
                            vs.send(.updateToggleSplit($0))
                        }
                        KeyboardShortcutView(.toggleBalance) {
                            vs.send(.updateToggleBalance($0))
                        }
                        KeyboardShortcutView(.toggleStacking) {
                            vs.send(.updateToggleStacking($0))
                        }
                        KeyboardShortcutView(.toggleFloating) {
                            vs.send(.updateToggleFloating($0))
                        }
                        KeyboardShortcutView(.toggleBSP) {
                            vs.send(.updateToggleBSP($0))
                        }
                    }
//                    HStack {
//                        HStack {
//                            Text("nonSKHD")
//                            Spacer()
//                        }
//                        .frame(width: 110)
//                        KeyboardShortcuts.Recorder(for: .nonSKHD)
//                    }
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

