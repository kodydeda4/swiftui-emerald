//
//  SpaceSettingsView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

struct YabaiSettingsView: View {
    let store: Store<YabaiSettings.State, YabaiSettings.Action>
    let keyPath = YabaiSettings.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                ScrollView {
                    TextField("", text: .constant(viewStore.asConfig))
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Section(header: Text("Global").fontWeight(.bold)) {
                            Divider()
                            Toggle("debugOutput", isOn: viewStore.binding(keyPath: \.debugOutput, send: keyPath))
                            Picker("externalBar", selection: viewStore.binding(keyPath: \.externalBar, send: keyPath)) {
                                ForEach(YabaiSettings.State.ExternalBar.allCases) {
                                    Text($0.rawValue)
                                }
                            }
                            Toggle("Mouse Follows Focus", isOn: viewStore.binding(keyPath: \.mouseFollowsFocus, send: keyPath))
                            Picker("Focus Follows Mouse", selection: viewStore.binding(keyPath: \.focusFollowsMouse, send: keyPath)) {
                                ForEach(YabaiSettings.State.FocusFollowsMouse.allCases) {
                                    Text($0.rawValue)
                                }
                            }
                        }
                        Section(header: Text("Window Misc").fontWeight(.bold)) {
                            Divider()
                            Picker("WindowPlacement", selection: viewStore.binding(keyPath: \.windowPlacement, send: keyPath)) {
                                ForEach(YabaiSettings.State.WindowPlacement.allCases) {
                                    Text($0.rawValue)
                                }
                            }
                            Toggle("Window Topmost", isOn: viewStore.binding(keyPath: \.windowTopmost, send: keyPath))
                            HStack {
                                Text("Window Shadow")
                                TextField("", value: viewStore.binding(keyPath: \.windowShadow, send: keyPath), formatter: NumberFormatter())
                            }
                        }
                        Section(header: Text("Window Opacity").fontWeight(.bold)) {
                            Divider()
                            Toggle("Window Opacity", isOn: viewStore.binding(keyPath: \.windowOpacity, send: keyPath))
                            HStack {
                                Text("windowOpacityDuration")
                                TextField("", value: viewStore.binding(keyPath: \.windowOpacityDuration, send: keyPath), formatter: NumberFormatter())
                            }
                            HStack {
                                Text("activeWindowOpacity")
                                TextField("", value: viewStore.binding(keyPath: \.activeWindowOpacity, send: keyPath), formatter: NumberFormatter())
                            }
                            HStack {
                                Text("normalWindowOpacity")
                                TextField("", value: viewStore.binding(keyPath: \.normalWindowOpacity, send: keyPath), formatter: NumberFormatter())
                            }
                        }
                        Section(header: Text("Window Borders").fontWeight(.bold)) {
                            Divider()
                            Toggle("Window Border", isOn: viewStore.binding(keyPath: \.windowBorder, send: keyPath))
                            HStack {
                                Text("Window Border Width")
                                TextField("", value: viewStore.binding(keyPath: \.windowBorderWidth, send: keyPath), formatter: NumberFormatter())
                            }
                            HStack {
                                Text("Active Window Border Color")
                                TextField("", text: viewStore.binding(keyPath: \.activeWindowBorderColor, send: keyPath))
                            }
                            HStack {
                                Text("normalWindowBorderColor")
                                TextField("", text: viewStore.binding(keyPath: \.normalWindowBorderColor, send: keyPath))
                            }
                        }
                        Section(header: Text("Misc").fontWeight(.bold)) {
                            Divider()
                            HStack {
                                Text("insertFeedbackColor")
                                TextField("", text: viewStore.binding(keyPath: \.insertFeedbackColor, send: keyPath))
                            }
                            HStack {
                                Text("splitRatio")
                                TextField("", value: viewStore.binding(keyPath: \.splitRatio, send: keyPath), formatter: NumberFormatter())
                            }
                            Toggle("autoBalance", isOn: viewStore.binding(keyPath: \.autoBalance, send: keyPath))
                        }
                        
                        Section(header: Text("Mouse Actions").fontWeight(.bold)) {
                            Picker("mouseModifier", selection: viewStore.binding(keyPath: \.mouseModifier, send: keyPath)) {
                                ForEach(YabaiSettings.State.MouseModifier.allCases) {
                                    Text($0.rawValue)
                                }
                            }
                            Picker("mouseAction1", selection: viewStore.binding(keyPath: \.mouseAction1, send: keyPath)) {
                                ForEach(YabaiSettings.State.MouseAction.allCases) {
                                    Text($0.rawValue)
                                }
                            }
                            Picker("mouseAction2", selection: viewStore.binding(keyPath: \.mouseAction2, send: keyPath)) {
                                ForEach(YabaiSettings.State.MouseAction.allCases) {
                                    Text($0.rawValue)
                                }
                            }
                            Picker("mouseDropAction", selection: viewStore.binding(keyPath: \.mouseDropAction, send: keyPath)) {
                                ForEach(YabaiSettings.State.MouseDropAction.allCases) {
                                    Text($0.rawValue)
                                }
                            }
                        }
                        
                        Section(header: Text("Space Settings").fontWeight(.bold)) {
                            Divider()
                            Picker("Layout", selection: viewStore.binding(keyPath: \.layout, send: keyPath)) {
                                ForEach(YabaiSettings.State.Layout.allCases) {
                                    Text($0.rawValue)
                                }
                            }
                            HStack {
                                Text("Top Padding")
                                TextField("", value: viewStore.binding(keyPath: \.paddingTop, send: keyPath), formatter: NumberFormatter())
                            }
                            HStack {
                                Text("Bottom Padding")
                                TextField("", value: viewStore.binding(keyPath: \.paddingBottom, send: keyPath), formatter: NumberFormatter())
                            }
                            HStack {
                                Text("Left Padding")
                                TextField("", value: viewStore.binding(keyPath: \.paddingLeft, send: keyPath), formatter: NumberFormatter())
                            }
                            HStack {
                                Text("Right Padding")
                                TextField("", value: viewStore.binding(keyPath: \.paddingRight, send: keyPath), formatter: NumberFormatter())
                            }
                            HStack {
                                Text("Window Gap")
                                TextField("", value: viewStore.binding(keyPath: \.windowGap, send: keyPath), formatter: NumberFormatter())
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}


struct YabaiSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        YabaiSettingsView(store: YabaiSettings.defaultStore)
    }
}

