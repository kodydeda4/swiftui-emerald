//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

struct DebugYabaiView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            HStack {
                DebugConfigFileView(text: vs.asConfig)
                
                ScrollView {
                    Text("Debug").font(.title)
                    Toggle("Enabled", isOn: vs.binding(keyPath: \.debugOutput, send: k))
                    Divider()
                    Text("Space").font(.title)
                    SpaceSettingsView(store: store).settings
                    Divider()
                    
                    Group {
                        Text("Window").font(.title)
                        WindowSettingsView(store: store).settings
                        Divider()
                        Text("Mouse").font(.title)
                        MouseSettingsView(store: store).settings
                        Divider()
                        Text("Bar").font(.title)
                        ExternalBarSettingsView(store: store).settings
                    }
                }
            }
            .navigationTitle("Debug Yabai")
        }
    }
}

// MARK:- YabaiSettingsView_Previews
struct YabaiSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DebugYabaiView(store: Yabai.defaultStore)
    }
}
