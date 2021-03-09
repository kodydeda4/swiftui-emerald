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
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack {
                Text("Mouse").font(.title)
                VStack {
                    Text("Mouse Follows Focus").bold()
                    Toggle("Enabled", isOn: vs.binding(keyPath: \.mouseFollowsFocus, send: k))
                }
                VStack {
                    Text("Focus Follows Focus").bold()
                    HStack {
                        Toggle("", isOn: vs.binding(keyPath: \.focusFollowsMouseEnabled, send: k)).labelsHidden()
                        
                        Picker("", selection: vs.binding(keyPath: \.focusFollowsMouse, send: k)) {
                            ForEach(Yabai.State.FocusFollowsMouse.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 150)
                        .disabled(!vs.focusFollowsMouseEnabled)
                    }
                }
                VStack {
                    Text("Modifier Key").bold()
                    Picker("", selection: vs.binding(keyPath: \.mouseModifier, send: k)) {
                        ForEach(Yabai.State.MouseModifier.allCases) {
                            //Image(systemName: "rectangle.grid.2x2.fill")
                            Text($0.uiDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 350)
                }
                VStack {
                    Text("Left Click + Modifier").bold()
                    Picker("", selection: vs.binding(keyPath: \.mouseAction1, send: k)) {
                        ForEach(Yabai.State.MouseAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
                }
                VStack {
                    Text("Right Click + Modifier").bold()
                    Picker("", selection: vs.binding(keyPath: \.mouseAction2, send: k)) {
                        ForEach(Yabai.State.MouseAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
                }
                VStack {
                    Text("Drop Action").bold()
                    Picker("", selection: vs.binding(keyPath: \.mouseDropAction, send: k)) {
                        ForEach(Yabai.State.MouseDropAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
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
