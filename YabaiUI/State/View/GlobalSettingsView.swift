//
//  GlobalSettingsView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/12/21.
//

import SwiftUI
import ComposableArchitecture

struct GlobalSettingsView: View {
    let store: Store<GlobalSettings.State, GlobalSettings.Action>
    var keyPath = GlobalSettings.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Section(header: Text("Global")) {
                    Toggle("Debug Output", isOn: viewStore.binding(keyPath: \.debugOutput, send: keyPath))
                    Picker("External Bar", selection: viewStore.binding(keyPath: \.externalBar, send: keyPath)) {
                        ForEach(GlobalSettings.State.ExternalBar.allCases) {
                            Text($0.rawValue)
                        }
                    }
                }
                Section(header: Text("Mouse")) {
                    Toggle("Mouse Follows Focus", isOn: viewStore.binding(keyPath: \.mouseFollowsFocus, send: keyPath))
                    Picker("Focus Follows Mouse", selection: viewStore.binding(keyPath: \.focusFollowsMouse, send: keyPath)) {
                        ForEach(GlobalSettings.State.FocusFollowsMouse.allCases) {
                            Text($0.rawValue)
                        }
                    }
                }
                Section(header: Text("Window")) {
                    Picker(
                        "Window Placement", selection: viewStore.binding(keyPath: \.windowPlacement, send: keyPath)) {
                        ForEach(GlobalSettings.State.WindowPlacement.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    Toggle("Window Topmost", isOn: viewStore.binding(keyPath: \.windowTopmost, send: keyPath))
                    Toggle("Window Shadow", isOn: viewStore.binding(keyPath: \.windowShadow, send: keyPath))
                    Toggle("Window Opacity", isOn: viewStore.binding(keyPath: \.windowOpacity, send: keyPath))
                    
                    HStack {
                        Text("Window Opacity Duration")
                        TextField("", value: viewStore.binding(keyPath: \.windowOpacityDuration, send: keyPath), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Active Window Opacity")
                        TextField("", value: viewStore.binding(keyPath: \.activeWindowOpacity, send: keyPath), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Normal Window Opacity")
                        TextField("",value: viewStore.binding(keyPath: \.normalWindowOpacity, send: keyPath), formatter: NumberFormatter())
                    }
                }
                Section(header: Text("Window Borders")) {
                    Toggle("Window Border", isOn: viewStore.binding(keyPath: \.windowBorder, send: keyPath))
                    HStack {
                        Text("Window Border Width")
                        TextField("", value: viewStore.binding(keyPath: \.windowBorderWidth, send: keyPath), formatter: NumberFormatter())
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
                        TextField("Split Ratio", value: viewStore.binding(keyPath: \.splitRatio, send: keyPath), formatter: NumberFormatter())
                    }
                    Toggle("Auto Balance", isOn: viewStore.binding(keyPath: \.autoBalance, send: keyPath))
                }
                Section(header: Text("Mouse Modifiers")) {
                    Picker("Mouse Modifier", selection: viewStore.binding(keyPath: \.mouseModifier, send: keyPath)) {
                        ForEach(GlobalSettings.State.MouseModifier.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    Picker("Mouse Action 1", selection: viewStore.binding(keyPath: \.mouseAction1, send: keyPath)) {
                        ForEach(GlobalSettings.State.MouseAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    Picker("Mouse Action 2", selection: viewStore.binding(keyPath: \.mouseAction2, send: keyPath)) {
                        ForEach(GlobalSettings.State.MouseAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    Picker("Mouse Action 2", selection: viewStore.binding(keyPath: \.mouseDropAction, send: keyPath)) {
                        ForEach(GlobalSettings.State.MouseDropAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                }
            }
        }
        .navigationTitle("Config")
    }
}

struct GlobalSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalSettingsView(store: GlobalSettings.defaultStore)
    }
}
