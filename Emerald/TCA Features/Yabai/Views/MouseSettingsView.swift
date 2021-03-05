//
//  MouseSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture

struct MouseSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let keyPath = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            SectionView("Mouse") {
                Toggle("Mouse Follows Focus", isOn: viewStore.binding(keyPath: \.mouseFollowsFocus, send: keyPath))
                
                VStack(alignment: .leading) {
                    Text("Focus Follows Mouse")
                    Picker("Focus Follows Mouse", selection: viewStore.binding(keyPath: \.focusFollowsMouse, send: keyPath)) {
                        ForEach(Yabai.State.FocusFollowsMouse.allCases) {
                            Text($0.rawValue)
                        }
                    }.labelsHidden()
                }
                
                VStack(alignment: .leading) {
                    Text("Mouse Modifier")
                    Picker("Mouse Modifier", selection: viewStore.binding(keyPath: \.mouseModifier, send: keyPath)) {
                        ForEach(Yabai.State.MouseModifier.allCases) {
                            Text($0.rawValue)
                        }
                    }.labelsHidden()
                }
                
                VStack(alignment: .leading) {
                    Text("Mouse Action 1")
                    Picker("Mouse Action 1", selection: viewStore.binding(keyPath: \.mouseAction1, send: keyPath)) {
                        ForEach(Yabai.State.MouseAction.allCases) {
                            Text($0.rawValue)
                        }
                    }.labelsHidden()
                }
                
                VStack(alignment: .leading) {
                    Text("Mouse Action 2")
                    Picker("Mouse Action 2", selection: viewStore.binding(keyPath: \.mouseAction2, send: keyPath)) {
                        ForEach(Yabai.State.MouseAction.allCases) {
                            Text($0.rawValue)
                        }
                    }.labelsHidden()
                }
                
                VStack(alignment: .leading) {
                    Text("Mouse Drop Action")
                    Picker("Mouse Drop Action", selection: viewStore.binding(keyPath: \.mouseDropAction, send: keyPath)) {
                        ForEach(Yabai.State.MouseDropAction.allCases) {
                            Text($0.rawValue)
                        }
                    }.labelsHidden()
                }
            }
        }
    }
}

// MARK:- SwiftUI_Previews
struct MouseSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MouseSettingsView(store: Yabai.defaultStore)
    }
}
