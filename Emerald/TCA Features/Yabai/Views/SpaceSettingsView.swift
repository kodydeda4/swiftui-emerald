//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 4/22/21.
//

import SwiftUI
import ComposableArchitecture
import KeyboardShortcuts

struct SpaceSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Picker("", selection: viewStore.binding(keyPath: \.layout, send: Yabai.Action.keyPath)) {
                ForEach(Yabai.State.Layout.allCases) {
                    Text($0.rawValue)
                }
            }
            .labelsHidden()
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 120)
        }
    }
}

struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Yabai.defaultStore)
    }
}

