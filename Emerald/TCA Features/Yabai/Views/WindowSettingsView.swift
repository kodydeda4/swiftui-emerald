//
//  WindowSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture






struct WindowSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let keyPath = Yabai.Action.keyPath
        
    var body: some View {
        WithViewStore(store) { viewStore in
            SectionView("Window") {
                Section(header: Text("Shadow Effects").bold()) {
                    HStack {
                        // ** do an inverse toggle") {
                        Button("Off (Normal)") {
                            viewStore.send(.updateWindowShadows(.on))
                        }
                        Button("Disabled") {
                            viewStore.send(.updateWindowShadows(.off))
                        }
                        Button("Floating-Only") {
                            viewStore.send(.updateWindowShadows(.float))
                        }
                    }
                }
                Divider()
                Section(header: Text("Opacity Effects").bold()) {
                    VStack(alignment: .leading) {
                        HStack {
                            Toggle("Opacity Effects", isOn: viewStore.binding(keyPath: \.windowOpacity, send: keyPath)).labelsHidden()
                            Text("Enabled")
                        }
                        Group {
                        MySliderView(text: "Animation Duration", value: viewStore.binding(keyPath: \.windowOpacityDuration, send: keyPath))
                        MySliderView(text: "Focused Window", value: viewStore.binding(keyPath: \.activeWindowOpacity, send: keyPath))
                        MySliderView(text: "Normal Windows", value: viewStore.binding(keyPath: \.normalWindowOpacity, send: keyPath))
                        }.disabled(!viewStore.windowOpacity)
                    }
                }
                Group {
                    Divider()
                    Section(header: Text("Borders").bold()) {
                        HStack {
                            VStack {
                                Toggle("Borders", isOn: viewStore.binding(keyPath: \.windowBorder, send: keyPath)).labelsHidden()
                                Text("")
                            }
                            Group {
                                VStack {
                                    MyStepperView("Width", value: viewStore.binding(keyPath: \.windowBorderWidth, send: keyPath))
                                }
                                MyColorPickerView(text: "Focused", selection: viewStore.binding(get: \.activeWindowBorderColor.color, send: Yabai.Action.updateActiveWindowBorderColor))
                                MyColorPickerView(text: "Normal", selection: viewStore.binding(get: \.normalWindowBorderColor.color, send: Yabai.Action.updateNormalWindowBorderColor))
                                MyColorPickerView(text: "Insert", selection: viewStore.binding(get: \.insertWindowBorderColor.color, send: Yabai.Action.updateInsertWindowBorderColor))
                            }
                            .disabled(!viewStore.windowBorder)
                        }
                        Divider()
                        Section(header: Text("New Window Placement").bold()) {
                            HStack {
                                Button("First Child") {
                                    viewStore.send(.updateWindowPlacement(.first_child))
                                }
                                Button("Second Child") {
                                    viewStore.send(.updateWindowPlacement(.second_child))
                                }
                            }
                        }
                        Divider()
                        Toggle("Auto Balance", isOn: viewStore.binding(keyPath: \.autoBalance, send: keyPath))

                        MySliderView(text: "Split Ratio", value: viewStore.binding(keyPath: \.splitRatio, send: keyPath))
                            .disabled(viewStore.autoBalance)
                        
                        Divider()
                        Section(header: Text("Floating Windows Stay-On-Top").bold()) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Enabled")
                                    Toggle("Floating Windows Stay-On-Top", isOn: viewStore.binding(keyPath: \.windowTopmost, send: keyPath)).labelsHidden()
                                }
                            }
                        }
                    }
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
