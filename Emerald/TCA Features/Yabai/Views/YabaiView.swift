//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

struct YabaiSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let keyPath = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                DebugConfigFileView(text: viewStore.asConfig)
                
                List {
                    VStack(alignment: .leading) {
                        SectionView("Debug") {
                            Toggle("Enabled", isOn: viewStore.binding(keyPath: \.debugOutput, send: keyPath))
                        }
                        SpaceSettingsView(store: store)
                        WindowSettingsView(store: store)
                        MouseSettingsView(store: store)
                        ExternalBarSettingsView(store: store)
                    }
                }.navigationTitle("Debug Yabai")
            }
        }
    }
}

// MARK:- YabaiSettingsView_Previews
struct YabaiSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        YabaiSettingsView(store: Yabai.defaultStore)
    }
}
