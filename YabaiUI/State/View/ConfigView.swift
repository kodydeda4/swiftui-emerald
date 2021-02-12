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
                Section {
                    Toggle("debugOutput", isOn: viewStore.binding(
                            get: \.debugOutput,
                            send: Config.Action.updateDebugOutput)
                    )
                    Picker("externalBar", selection:
                            viewStore.binding(
                                get: \.externalBar,
                                send: Config.Action.updateExternalBar)
                    ) {
                        ForEach(Config.State.ExternalBar.allCases) {
                            Text($0.rawValue)
                        }
                    }
                }
                Section {
                    Toggle("mouseFollowsFocus", isOn: viewStore.binding(
                            get: \.mouseFollowsFocus,
                            send: Config.Action.updateMouseFollowsFocus)
                    )
                    Picker("focusFollowsMouse", selection:
                            viewStore.binding(
                                get: \.focusFollowsMouse,
                                send: Config.Action.updateFocusFollowsMouse)
                    ) {
                        ForEach(Config.State.FocusFollowsMouse.allCases) {
                            Text($0.rawValue)
                        }
                    }
                }
                Section {
                    Picker("windowPlacement", selection:
                            viewStore.binding(
                                get: \.windowPlacement,
                                send: Config.Action.updateWindowPlacement)
                    ) {
                        ForEach(Config.State.WindowPlacement.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    Toggle("windowTopmost", isOn: viewStore.binding(
                            get: \.windowTopmost,
                            send: Config.Action.updateWindowTopmost)
                    )
                    Toggle("windowShadow", isOn: viewStore.binding(
                            get: \.windowShadow,
                            send: Config.Action.updateWindowShadow)
                    )
                    Toggle("windowOpacity", isOn: viewStore.binding(
                            get: \.windowOpacity,
                            send: Config.Action.updateWindowOpacity)
                    )
                }
                Section {
                    HStack {
                        Text("windowOpacityDuration")
                        TextField(
                            "windowOpacityDuration",
                            value: viewStore.binding(
                                get: \.windowOpacityDuration,
                                send: Config.Action.updateWindowOpacityDuration),
                            formatter: NumberFormatter()
                        )
                    }
                    Section {
                        HStack {
                            Text("activeWindowOpacity")
                            TextField(
                                "activeWindowOpacity",
                                value: viewStore.binding(
                                    get: \.activeWindowOpacity,
                                    send: Config.Action.updateActiveWindowOpacity),
                                formatter: NumberFormatter()
                            )
                        }
                        HStack {
                            Text("normalWindowOpacity")
                            TextField(
                                "normalWindowOpacity",
                                value: viewStore.binding(
                                    get: \.normalWindowOpacity,
                                    send: Config.Action.updateNormalWindowOpacity),
                                formatter: NumberFormatter()
                            )
                        }
                    }
                    Section {
                        
                        Toggle("windowBorder", isOn: viewStore.binding(
                                get: \.windowBorder,
                                send: Config.Action.updateWindowBorder)
                        )
                        HStack {
                            Text("windowBorderWidth")
                            TextField(
                                "windowBorderWidth",
                                value: viewStore.binding(
                                    get: \.windowBorderWidth,
                                    send: Config.Action.updateWindowBorderWidth),
                                formatter: NumberFormatter()
                            )
                        }
                        ColorPicker(
                            "activeWindowBorderColor",
                            selection: viewStore.binding(
                                get: \.activeWindowBorderColor,
                                send: Config.Action.updateActiveWindowBorderColor
                            )
                        )
                        ColorPicker(
                            "normalWindowBorderColor",
                            selection: viewStore.binding(
                                get: \.normalWindowBorderColor,
                                send: Config.Action.updateNormalWindowBorderColor
                            )
                        )
                        ColorPicker(
                            "insertFeedbackColor",
                            selection: viewStore.binding(
                                get: \.insertFeedbackColor,
                                send: Config.Action.updateInsertFeedbackColor
                            )
                        )
                    }
                    Section {
                        
                        HStack {
                            Text("splitRatio")
                            TextField(
                                "splitRatio",
                                value: viewStore.binding(
                                    get: \.splitRatio,
                                    send: Config.Action.updateSplitRatio),
                                formatter: NumberFormatter()
                            )
                        }
                        Toggle("autoBalance", isOn: viewStore.binding(
                                get: \.autoBalance,
                                send: Config.Action.updateAutoBalance)
                        )
                    }
                    Section {
                        
                        Picker("mouseModifier", selection:
                                viewStore.binding(
                                    get: \.mouseModifier,
                                    send: Config.Action.updateMouseModifier)
                        ) {
                            ForEach(Config.State.MouseModifier.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        Picker("mouseAction1", selection:
                                viewStore.binding(
                                    get: \.mouseAction1,
                                    send: Config.Action.updateMouseAction1)
                        ) {
                            ForEach(Config.State.MouseAction.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        Picker("mouseAction2", selection:
                                viewStore.binding(
                                    get: \.mouseAction2,
                                    send: Config.Action.updateMouseAction2)
                        ) {
                            ForEach(Config.State.MouseAction.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        Picker("mouseAction2", selection:
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
        .navigationTitle("Config")
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView(store: Config.defaultStore)
    }
}
