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
    
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                DebugView(store: store)
                MouseSettingsView(store: store)
                WindowView(store: store)
                BordersView(store: store)
                SplitRatioView(store: store)
                MouseModifierView(store: store)
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

// MARK:- Subviews

struct DebugView: View {
    let store: Store<Config.State, Config.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Section(header: Text("Global")) {
                Toggle(
                    "Debug Output",
                    isOn: viewStore.binding(
                        get: \.debugOutput,
                        send: Config.Action.updateDebugOutput)
                )
                Picker(
                    "External Bar",
                    selection:
                        viewStore.binding(
                            get: \.externalBar,
                            send: Config.Action.updateExternalBar)
                ) {
                    ForEach(Config.State.ExternalBar.allCases) {
                        Text($0.rawValue)
                    }
                }
            }
        }
    }
}

private struct MouseSettingsView: View {
    let store: Store<Config.State, Config.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Section(header: Text("Mouse")) {
                Toggle(
                    "Mouse Follows Focus",
                    isOn: viewStore.binding(
                        get: \.mouseFollowsFocus,
                        send: Config.Action.updateMouseFollowsFocus
                    )
                )
                Picker(
                    "Focus Follows Mouse",
                    selection:
                        viewStore.binding(
                            get: \.focusFollowsMouse,
                            send: Config.Action.updateFocusFollowsMouse)
                ) {
                    ForEach(Config.State.FocusFollowsMouse.allCases) {
                        Text($0.rawValue)
                    }
                }
            }
        }
    }
}


private struct WindowView: View {
    let store: Store<Config.State, Config.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Section(header: Text("Window")) {
                Picker(
                    "Window Placement",
                    selection: viewStore.binding(
                        get: \.windowPlacement,
                        send: Config.Action.updateWindowPlacement
                    )
                ) {
                    ForEach(Config.State.WindowPlacement.allCases) {
                        Text($0.rawValue)
                    }
                }
                Toggle(
                    "Window Topmost",
                    isOn: viewStore.binding(
                        get: \.windowTopmost,
                        send: Config.Action.updateWindowTopmost
                    )
                )
                Toggle(
                    "Window Shadow",
                    isOn: viewStore.binding(
                        get: \.windowShadow,
                        send: Config.Action.updateWindowShadow
                    )
                )
                Toggle(
                    "Window Opacity",
                    isOn: viewStore.binding(
                        get: \.windowOpacity,
                        send: Config.Action.updateWindowOpacity
                    )
                )
                
                
                HStack {
                    Text("Window Opacity Duration")
                    TextField(
                        "",
                        value: viewStore.binding(
                            get: \.windowOpacityDuration,
                            send: Config.Action.updateWindowOpacityDuration
                        ),
                        formatter: NumberFormatter()
                    )
                }
                HStack {
                    Text("Active Window Opacity")
                    TextField(
                        "",
                        value: viewStore.binding(
                            get: \.activeWindowOpacity,
                            send: Config.Action.updateActiveWindowOpacity
                        ),
                        formatter: NumberFormatter()
                    )
                }
                HStack {
                    Text("Normal Window Opacity")
                    TextField(
                        "",
                        value: viewStore.binding(
                            get: \.normalWindowOpacity,
                            send: Config.Action.updateNormalWindowOpacity
                        ),
                        formatter: NumberFormatter()
                    )
                }
            }
        }
    }
}

private struct BordersView: View {
    let store: Store<Config.State, Config.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Section(header: Text("Window Borders")) {
                Toggle("Window Border", isOn: viewStore.binding(
                        get: \.windowBorder,
                        send: Config.Action.updateWindowBorder)
                )
                HStack {
                    Text("Window Border Width")
                    TextField(
                        "",
                        value: viewStore.binding(
                            get: \.windowBorderWidth,
                            send: Config.Action.updateWindowBorderWidth),
                        formatter: NumberFormatter()
                    )
                }
                ColorPicker(
                    "Active Window Border Color",
                    selection: viewStore.binding(
                        get: \.activeWindowBorderColor,
                        send: Config.Action.updateActiveWindowBorderColor
                    )
                )
                ColorPicker(
                    "Normal Window Border Color",
                    selection: viewStore.binding(
                        get: \.normalWindowBorderColor,
                        send: Config.Action.updateNormalWindowBorderColor
                    )
                )
                ColorPicker(
                    "Insert Feedback Color",
                    selection: viewStore.binding(
                        get: \.insertFeedbackColor,
                        send: Config.Action.updateInsertFeedbackColor
                    )
                )
            }
        }
    }
}

private struct SplitRatioView: View {
    let store: Store<Config.State, Config.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Section(header: Text("Split Ratios")) {
                HStack {
                    Text("Split Ratio")
                    TextField(
                        "Split Ratio",
                        value: viewStore.binding(
                            get: \.splitRatio,
                            send: Config.Action.updateSplitRatio),
                        formatter: NumberFormatter()
                    )
                }
                Toggle("Auto Balance", isOn: viewStore.binding(
                        get: \.autoBalance,
                        send: Config.Action.updateAutoBalance)
                )
            }
        }
    }
}

private struct MouseModifierView: View {
    let store: Store<Config.State, Config.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Section(header: Text("Mouse Modifiers")) {
                Picker("Mouse Modifier", selection:
                        viewStore.binding(
                            get: \.mouseModifier,
                            send: Config.Action.updateMouseModifier)
                ) {
                    ForEach(Config.State.MouseModifier.allCases) {
                        Text($0.rawValue)
                    }
                }
                Picker("Mouse Action 1", selection:
                        viewStore.binding(
                            get: \.mouseAction1,
                            send: Config.Action.updateMouseAction1)
                ) {
                    ForEach(Config.State.MouseAction.allCases) {
                        Text($0.rawValue)
                    }
                }
                Picker("Mouse Action 2", selection:
                        viewStore.binding(
                            get: \.mouseAction2,
                            send: Config.Action.updateMouseAction2)
                ) {
                    ForEach(Config.State.MouseAction.allCases) {
                        Text($0.rawValue)
                    }
                }
                Picker("Mouse Action 2", selection:
                        viewStore.binding(
                            get: \.mouseDropAction,
                            send: Config.Action.updateMouseDropAction)
                ) {
                    ForEach(Config.State.MouseDropAction.allCases) {
                        Text($0.rawValue)
                    }
                }
            }
        }
    }
}
