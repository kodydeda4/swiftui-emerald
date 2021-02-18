//
//  SKHDSettingsView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/17/21.
//

import SwiftUI
import ComposableArchitecture
import KeyboardShortcuts

struct SKHDSettingsView: View {
    let store: Store<SKHDSettings.State, SKHDSettings.Action>
    let keyPath = SKHDSettings.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                ScrollView {
                    TextField("", text: .constant(viewStore.asConfig))
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Section(header: Text("Section A").fontWeight(.bold)) {
                            HStack {
                                Text("Toggle Padding")
                                KeyboardShortcuts.Recorder(for: .togglePaddingShortcut, onChange: { viewStore.send(.updateTogglePaddingShortcut($0)) })
                            }
                            HStack {
                                Text("Toggle Gaps")
                                KeyboardShortcuts.Recorder(for: .toggleGapsShortcut, onChange: { viewStore.send(.updateToggleGapsShortcut($0)) })
                            }
                            HStack {
                                Text("Toggle Split")
                                KeyboardShortcuts.Recorder(for: .toggleSplitShortcut, onChange: { viewStore.send(.updateToggleSplitShortcut($0)) })
                            }
                            
                            HStack {
                                Text("Toggle Balance")
                                KeyboardShortcuts.Recorder(for: .toggleBalanceShortcut, onChange: { viewStore.send(.updateToggleBalanceShortcut($0)) })
                            }
                            HStack {
                                Text("Toggle Stacking")
                                KeyboardShortcuts.Recorder(for: .toggleStackingShortcut, onChange: { viewStore.send(.updateToggleStackingShortcut($0)) })
                            }
                            HStack {
                                Text("Toggle Floating")
                                KeyboardShortcuts.Recorder(for: .toggleFloatingShortcut, onChange: { viewStore.send(.updateToggleFloatingShortcut($0)) })
                            }
                            HStack {
                                Text("Toggle BSP")
                                KeyboardShortcuts.Recorder(for: .toggleBSPShortcut, onChange: { viewStore.send(.updateToggleBSPShortcut($0)) })
                            }
                            Picker("", selection: .constant("")) {
                                ForEach(0..<3) {
                                    Text($0.description)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct SKHDSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SKHDSettingsView(store: SKHDSettings.defaultStore)
    }
}

