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
                        SectionView("Section TITLE") {
                            Toggle("Debug Output", isOn: viewStore.binding(keyPath: \.debugOutput, send: keyPath))
                        }
                        SectionView("External Bar") {
                            Picker("External Bar", selection: viewStore.binding(keyPath: \.externalBar, send: keyPath)) { ForEach(Yabai.State.ExternalBar.allCases) { Text($0.rawValue) } }
                            Group {
                                SpecialTextField(title: "Top Padding", value: viewStore.binding(keyPath: \.topPaddingExternalBar, send: keyPath))
                                SpecialTextField(title: "Bottom Padding", value: viewStore.binding(keyPath: \.bottomPaddingExternalBar, send: keyPath))
                            }
                            .disabled(viewStore.externalBar == .off)
                        }
                        SectionView("Section TITLE") {
                            Toggle("Mouse Follows Focus", isOn: viewStore.binding(keyPath: \.mouseFollowsFocus, send: keyPath))
                            Picker("Focus Follows Mouse", selection: viewStore.binding(keyPath: \.focusFollowsMouse, send: keyPath)) { ForEach(Yabai.State.FocusFollowsMouse.allCases) { Text($0.rawValue) } }
                        }
                        SectionView("Window Misc") {
                            Picker("Window Placement", selection: viewStore.binding(keyPath: \.windowPlacement, send: keyPath)) { ForEach(Yabai.State.WindowPlacement.allCases) { Text($0.rawValue) } }
                            Toggle("Window Topmost", isOn: viewStore.binding(keyPath: \.windowTopmost, send: keyPath))
                            Picker("Window Shadow", selection: viewStore.binding(keyPath: \.windowShadow, send: keyPath)) { ForEach(Yabai.State.WindowShadow.allCases) { Text($0.rawValue) } }
                        }
                        SectionView("Window Opacity") {
                            Toggle("Window Opacity", isOn: viewStore.binding(keyPath: \.windowOpacity, send: keyPath))
                            Group {
                                SpecialTextFieldFloats(title: "Window Opacity Duration", value: viewStore.binding(keyPath: \.windowOpacityDuration, send: keyPath))
                                SpecialTextFieldFloats(title: "Active Window Opacity", value: viewStore.binding(keyPath: \.activeWindowOpacity, send: keyPath))
                                SpecialTextFieldFloats(title: "Normal Window Opacity", value: viewStore.binding(keyPath: \.normalWindowOpacity, send: keyPath))
                            }
                            .disabled(!viewStore.windowOpacity)
                        }
                        SectionView("Window Borders") {
                            Toggle("Window Border", isOn: viewStore.binding(keyPath: \.windowBorder, send: keyPath))
                            Group {
                                SpecialTextField(title: "Window Border Width", value: viewStore.binding(keyPath: \.windowBorderWidth, send: keyPath))
                                ColorPicker("Active Window Border Color", selection: viewStore.binding(get: \.activeWindowBorderColor.color, send: Yabai.Action.updateActiveWindowBorderColor))
                                ColorPicker("Normal Window Border Color", selection: viewStore.binding(get: \.normalWindowBorderColor.color, send: Yabai.Action.updateNormalWindowBorderColor))
                                ColorPicker("Insert Feedback Color", selection: viewStore.binding(get: \.insertWindowBorderColor.color, send: Yabai.Action.updateInsertWindowBorderColor))
                            }
                            .disabled(!viewStore.windowBorder)
                        }
                        SectionView("Misc") {
                            Toggle("Auto Balance", isOn: viewStore.binding(keyPath: \.autoBalance, send: keyPath))
                            Group {
                                SpecialTextFieldFloats(title: "Split Ratio", value: viewStore.binding(keyPath: \.splitRatio, send: keyPath))
                            }
                            .disabled(viewStore.autoBalance)
                            
                        }
                        SectionView("Mouse Actions") {
                            Picker("Mouse Modifier", selection: viewStore.binding(keyPath: \.mouseModifier, send: keyPath)) { ForEach(Yabai.State.MouseModifier.allCases) { Text($0.rawValue) } }
                            Picker("Mouse Action 1", selection: viewStore.binding(keyPath: \.mouseAction1, send: keyPath)) { ForEach(Yabai.State.MouseAction.allCases) { Text($0.rawValue) } }
                            Picker("Mouse Action 2", selection: viewStore.binding(keyPath: \.mouseAction2, send: keyPath)) { ForEach(Yabai.State.MouseAction.allCases) { Text($0.rawValue) } }
                            Picker("Mouse Drop Action", selection: viewStore.binding(keyPath: \.mouseDropAction, send: keyPath)) { ForEach(Yabai.State.MouseDropAction.allCases) { Text($0.rawValue) } }
                        }
                        SectionView("Space Settings") {
                            Picker("Layout", selection: viewStore.binding(keyPath: \.layout, send: keyPath)) { ForEach(Yabai.State.Layout.allCases) { Text($0.rawValue) } }
                            SpecialTextField(title: "Top Padding", value: viewStore.binding(keyPath: \.paddingTop, send: keyPath))
                            SpecialTextField(title: "Bottom Padding", value: viewStore.binding(keyPath: \.paddingBottom, send: keyPath))
                            SpecialTextField(title: "Left Padding", value: viewStore.binding(keyPath: \.paddingLeft, send: keyPath))
                            SpecialTextField(title: "Right Padding", value: viewStore.binding(keyPath: \.paddingRight, send: keyPath))
                            SpecialTextField(title: "Window Gap", value: viewStore.binding(keyPath: \.windowGap, send: keyPath))
                        }
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
        YabaiSettingsView(store: Yabai.defaultStore)
    }
}
