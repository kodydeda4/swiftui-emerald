//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

/*
 Todo:
 - CustomPickerView (one-line).
 - CustomTextfieldView (generic).
 */

struct YabaiSettingsView: View {
    let store: Store<YabaiSettings.State, YabaiSettings.Action>
    let keyPath = YabaiSettings.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                ConfigFileView(text: viewStore.asConfig)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        SectionView("Section TITLE") {
                            Toggle("Debug Output", isOn: viewStore.binding(keyPath: \.debugOutput, send: keyPath))
                        }
                            SectionView("External Bar") {
                                Picker("External Bar", selection: viewStore.binding(keyPath: \.externalBar, send: keyPath)) { ForEach(YabaiSettings.State.ExternalBar.allCases) { Text($0.rawValue) } }
                                SpecialTextField(title: "Top Padding", value: viewStore.binding(keyPath: \.topPaddingExternalBar, send: keyPath), disabled: viewStore.externalBar == .off)
                                SpecialTextField(title: "Bottom Padding", value: viewStore.binding(keyPath: \.bottomPaddingExternalBar, send: keyPath), disabled: viewStore.externalBar == .off)
                            }
                        
                        SectionView("Section TITLE") {
                            Toggle("Mouse Follows Focus", isOn: viewStore.binding(keyPath: \.mouseFollowsFocus, send: keyPath))
                            Picker("Focus Follows Mouse", selection: viewStore.binding(keyPath: \.focusFollowsMouse, send: keyPath)) { ForEach(YabaiSettings.State.FocusFollowsMouse.allCases) { Text($0.rawValue) } }
                        }
                        
//                        //MARK:-
                        SectionView("Window Misc") {
                            Picker("Window Placement", selection: viewStore.binding(keyPath: \.windowPlacement, send: keyPath)) { ForEach(YabaiSettings.State.WindowPlacement.allCases) { Text($0.rawValue) } }
                            Toggle("Window Topmost", isOn: viewStore.binding(keyPath: \.windowTopmost, send: keyPath))
                            Picker("Window Shadow", selection: viewStore.binding(keyPath: \.windowShadow, send: keyPath)) { ForEach(YabaiSettings.State.WindowShadow.allCases) { Text($0.rawValue) } }
                        }
                        SectionView("Window Opacity") {
                            Toggle("Window Opacity", isOn: viewStore.binding(keyPath: \.windowOpacity, send: keyPath))
                            SpecialTextFieldFloats(title: "Window Opacity Duration", value: viewStore.binding(keyPath: \.windowOpacityDuration, send: keyPath), disabled: !viewStore.windowOpacity)
                            SpecialTextFieldFloats(title: "Active Window Opacity", value: viewStore.binding(keyPath: \.activeWindowOpacity, send: keyPath), disabled: !viewStore.windowOpacity)
                            SpecialTextFieldFloats(title: "Normal Window Opacity", value: viewStore.binding(keyPath: \.normalWindowOpacity, send: keyPath), disabled: !viewStore.windowOpacity)
                        }
//                        SectionView("Window Borders") {
//                            Toggle("Window Border", isOn: viewStore.binding(keyPath: \.windowBorder, send: keyPath))
//                            SpecialTextField(title: "Window Border Width", value: viewStore.binding(keyPath: \.windowBorderWidth, send: keyPath), disabled: viewStore.windowBorder)
//                            SpecialTextFieldStrings(title: "Active Window Border Color", value: viewStore.binding(keyPath: \.activeWindowBorderColor, send: keyPath))
//                            SpecialTextFieldStrings(title: "Normal Window Border Color", value: viewStore.binding(keyPath: \.normalWindowBorderColor, send: keyPath))
//                        SpecialTextFieldStrings(title: "Insert Feedback Color", value: viewStore.binding(keyPath: \.insertFeedbackColor, send: keyPath))

//                        }
                        SectionView("Misc") {
                            Toggle("Auto Balance", isOn: viewStore.binding(keyPath: \.autoBalance, send: keyPath))
                            SpecialTextFieldFloats(title: "Split Ratio", value: viewStore.binding(keyPath: \.splitRatio, send: keyPath), disabled: viewStore.autoBalance)
                        }
//                        SectionView("Mouse Actions") {
//                            Picker("Mouse Modifier", selection: viewStore.binding(keyPath: \.mouseModifier, send: keyPath)) { ForEach(YabaiSettings.State.MouseModifier.allCases) { Text($0.rawValue) } }
//                            Picker("Mouse Action 1", selection: viewStore.binding(keyPath: \.mouseAction1, send: keyPath)) { ForEach(YabaiSettings.State.MouseAction.allCases) { Text($0.rawValue) } }
//                            Picker("Mouse Action 2", selection: viewStore.binding(keyPath: \.mouseAction2, send: keyPath)) { ForEach(YabaiSettings.State.MouseAction.allCases) { Text($0.rawValue) } }
//                            Picker("Mouse Drop Action", selection: viewStore.binding(keyPath: \.mouseDropAction, send: keyPath)) { ForEach(YabaiSettings.State.MouseDropAction.allCases) { Text($0.rawValue) } }
//                        }
                        //MARK:-
                        SectionView("Space Settings") {
                            Picker("Layout", selection: viewStore.binding(keyPath: \.layout, send: keyPath)) { ForEach(YabaiSettings.State.Layout.allCases) { Text($0.rawValue) } }
                            SpecialTextField(title: "Top Padding", value: viewStore.binding(keyPath: \.paddingTop, send: keyPath), disabled: false)
                            SpecialTextField(title: "Bottom Padding", value: viewStore.binding(keyPath: \.paddingBottom, send: keyPath), disabled: false)
                            SpecialTextField(title: "Left Padding", value: viewStore.binding(keyPath: \.paddingLeft, send: keyPath), disabled: false)
                            SpecialTextField(title: "Right Padding", value: viewStore.binding(keyPath: \.paddingRight, send: keyPath), disabled: false)
                            SpecialTextField(title: "Window Gap", value: viewStore.binding(keyPath: \.windowGap, send: keyPath), disabled: false)
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
        YabaiSettingsView(store: YabaiSettings.defaultStore)
    }
}
