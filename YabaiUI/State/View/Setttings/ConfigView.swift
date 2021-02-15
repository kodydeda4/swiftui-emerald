//
//  ConfigView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/12/21.
//

import SwiftUI
import ComposableArchitecture

struct ConfigView: View {
    let store: Store<Config.State, Config.Action>
    var form = Config.Action.form
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Section(header: Text("Global")) {
                    Toggle("Debug Output", isOn: viewStore.binding(keyPath: \.debugOutput, send: form))
                    Picker("External Bar", selection: viewStore.binding(keyPath: \.externalBar, send: form)) {
                        ForEach(Config.State.ExternalBar.allCases) {
                            Text($0.rawValue)
                        }
                    }
                }
                Section(header: Text("Mouse")) {
                    Toggle("Mouse Follows Focus", isOn: viewStore.binding(keyPath: \.mouseFollowsFocus, send: form))
                    Picker("Focus Follows Mouse", selection: viewStore.binding(keyPath: \.focusFollowsMouse, send: form)) {
                        ForEach(Config.State.FocusFollowsMouse.allCases) {
                            Text($0.rawValue)
                        }
                    }
                }
                Section(header: Text("Window")) {
                    Picker(
                        "Window Placement", selection: viewStore.binding(keyPath: \.windowPlacement, send: form)) {
                        ForEach(Config.State.WindowPlacement.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    Toggle("Window Topmost", isOn: viewStore.binding(keyPath: \.windowTopmost, send: form))
                    Toggle("Window Shadow", isOn: viewStore.binding(keyPath: \.windowShadow, send: form))
                    Toggle("Window Opacity", isOn: viewStore.binding(keyPath: \.windowOpacity, send: form))
                    
                    HStack {
                        Text("Window Opacity Duration")
                        TextField("", value: viewStore.binding(keyPath: \.windowOpacityDuration, send: form), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Active Window Opacity")
                        TextField("", value: viewStore.binding(keyPath: \.activeWindowOpacity, send: form), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Normal Window Opacity")
                        TextField("",value: viewStore.binding(keyPath: \.normalWindowOpacity, send: form), formatter: NumberFormatter())
                    }
                }
                Section(header: Text("Window Borders")) {
                    Toggle("Window Border", isOn: viewStore.binding(keyPath: \.windowBorder, send: form))
                    HStack {
                        Text("Window Border Width")
                        TextField("", value: viewStore.binding(keyPath: \.windowBorderWidth, send: form), formatter: NumberFormatter())
                    }
//                    ColorPicker(
//                        "Active Window Border Color",
//                        selection: viewStore.binding(keyPath: \.activeWindowBorderColor, send: form)
//                    )
//                    ColorPicker(
//                        "Normal Window Border Color",
//                        selection: viewStore.binding(keyPath: \.normalWindowBorderColor, send: form)
//                    )
//                    ColorPicker(
//                        "Insert Feedback Color",
//                        selection: viewStore.binding(keyPath: \.insertFeedbackColor, send: form)
//                    )
                }
                Section(header: Text("Split Ratios")) {
                    HStack {
                        Text("Split Ratio")
                        TextField("Split Ratio", value: viewStore.binding(keyPath: \.splitRatio, send: form), formatter: NumberFormatter())
                    }
                    Toggle("Auto Balance", isOn: viewStore.binding(keyPath: \.autoBalance, send: form))
                }
                Section(header: Text("Mouse Modifiers")) {
                    Picker("Mouse Modifier", selection: viewStore.binding(keyPath: \.mouseModifier, send: form)) {
                        ForEach(Config.State.MouseModifier.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    Picker("Mouse Action 1", selection: viewStore.binding(keyPath: \.mouseAction1, send: form)) {
                        ForEach(Config.State.MouseAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    Picker("Mouse Action 2", selection: viewStore.binding(keyPath: \.mouseAction2, send: form)) {
                        ForEach(Config.State.MouseAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    Picker("Mouse Action 2", selection: viewStore.binding(keyPath: \.mouseDropAction, send: form)) {
                        ForEach(Config.State.MouseDropAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                }
            }
        }
        .navigationTitle("Config")
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView(store: Config.defaultStore)
    }
}
