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
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Yabai.defaultStore)
    }
}
