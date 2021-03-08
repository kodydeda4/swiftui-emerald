//
//  WindowSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture

struct OpacitySettings: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            Section(header:
                        HStack {
                            Toggle(
                                "Opacity Effects",
                                isOn: vs.binding(keyPath: \.windowOpacity, send: k)
                            )
                            .labelsHidden()
                            Text("Opacity Effects").bold()
                        }
            ) {
                VStack(alignment: .leading) {
                    Group {
                        SliderView(
                            text: "Animation Duration",
                            value: vs.binding(
                                get: \.windowOpacityDuration,
                                send: Yabai.Action.updateWindowOpacityDuration
                            ),
                            isEnabled: vs.windowOpacity
                        )
                        SliderView(
                            text: "Focused Window",
                            value: vs.binding(
                                get: \.activeWindowOpacity,
                                send: Yabai.Action.updatetActiveWindowOpacity
                            ),
                            isEnabled: vs.windowOpacity
                        )
                        SliderView(
                            text: "Normal Windows",
                            value: vs.binding(
                                get: \.normalWindowOpacity,
                                send: Yabai.Action.updateNormalWindowOpacity
                            ),
                            isEnabled: vs.windowOpacity
                        )
                    }
                }
            }
        }
    }
}


struct BorderSettings: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            Section(header: Text("Borders").bold()) {
                HStack {
                    VStack {
                        Toggle(
                            "Borders",
                            isOn: vs.binding(keyPath: \.windowBorder, send: k)
                        )
                        .labelsHidden()
                        Text("")
                    }
                    Group {
                        StepperView(
                            text: "Width",
                            value: vs.binding(keyPath: \.windowBorderWidth, send: k),
                            isEnabled: vs.windowBorder
                        )
                        ColorPickerView(
                            text: "Focused",
                            selection: vs.binding(
                                get: \.activeWindowBorderColor.color,
                                send: Yabai.Action.updateActiveWindowBorderColor
                            )
                        )
                        ColorPickerView(
                            text: "Normal",
                            selection: vs.binding(
                                get: \.normalWindowBorderColor.color,
                                send: Yabai.Action.updateNormalWindowBorderColor
                            )
                        )
                        ColorPickerView(
                            text: "Insert",
                            selection: vs.binding(
                                get: \.insertWindowBorderColor.color,
                                send: Yabai.Action.updateInsertWindowBorderColor
                            )
                        )
                    }
                    .disabled(!vs.windowBorder)
                }
                Divider()
                Section(header: Text("New Window Placement").bold()) {
                    HStack {
                        Button("First Child") {
                            vs.send(.updateWindowPlacement(.first_child))
                        }
                        Button("Second Child") {
                            vs.send(.updateWindowPlacement(.second_child))
                        }
                    }
                }
                Divider()
                Toggle(
                    "Auto Balance",
                    isOn: vs.binding(keyPath: \.autoBalance, send: k)
                )
                SliderView(
                    text: "Split Ratio",
                    value: vs.binding(keyPath: \.splitRatio, send: k),
                    isEnabled: !vs.autoBalance
                )
                Divider()
                Section(header: Text("Floating Windows Stay-On-Top").bold()) {
                    VStack(alignment: .leading) {
                        HStack {
                            Toggle(
                                "Floating Windows Stay-On-Top",
                                isOn: vs.binding(
                                    keyPath: \.windowTopmost,
                                    send: k
                                )
                            )
                            .labelsHidden()
                            Text("Enabled")
                        }
                    }
                }
            }
        }
    }
}


struct WindowSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            SectionView("Window") {
                Section(header: Text("Shadow Effects").bold()) {
                    HStack {
                        // ** do an inverse toggle") {
                        Button("Off (Normal)") {
                            vs.send(.updateWindowShadows(.on))
                        }
                        Button("Disabled") {
                            vs.send(.updateWindowShadows(.off))
                        }
                        Button("Floating-Only") {
                            vs.send(.updateWindowShadows(.float))
                        }
                    }
                }
                Divider()
                OpacitySettings(store: store)
                Group {
                    Divider()
                    BorderSettings(store: store)
                }
            }
        }
    }
}
// MARK:- SwiftUI_Previews
struct WindowSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        WindowSettingsView(store: Yabai.defaultStore)
    }
}
