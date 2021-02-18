//
//  SpaceSettingsView.swift
//  YabaiUI
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
                ScrollView {
                    TextField("", text: .constant(viewStore.asConfig))
                }
                .padding()
                
                ScrollView {
                    VStack(alignment: .leading) {
//                        SectionView("Window Borders") {
//                            Toggle("debugOutput", isOn:              viewStore.binding(keyPath: \.debugOutput,       send: keyPath))
//                            Picker("externalBar", selection:         viewStore.binding(keyPath: \.externalBar,       send: keyPath)) { ForEach(YabaiSettings.State.ExternalBar.allCases)       { Text($0.rawValue) } }
//                            Toggle("Mouse Follows Focus", isOn:      viewStore.binding(keyPath: \.mouseFollowsFocus, send: keyPath))
//                            Picker("Focus Follows Mouse", selection: viewStore.binding(keyPath: \.focusFollowsMouse, send: keyPath)) { ForEach(YabaiSettings.State.FocusFollowsMouse.allCases) { Text($0.rawValue) } }
//                        }
//                        SectionView("Window Misc") {
//                            Picker("WindowPlacement", selection: viewStore.binding(keyPath: \.windowPlacement, send: keyPath)) { ForEach(YabaiSettings.State.WindowPlacement.allCases) { Text($0.rawValue) } }
//                            Toggle("Window Topmost", isOn: viewStore.binding(keyPath: \.windowTopmost, send: keyPath))
//                            SpecialTextFieldFloats(title: "Window Shadow", value: viewStore.binding(keyPath: \.windowShadow, send: keyPath))
//                        }
//                        SectionView("Window Opacity") {
//                            Toggle("Window Opacity", isOn: viewStore.binding(keyPath: \.windowOpacity, send: keyPath))
//                            SpecialTextFieldFloats(title: "Window Opacity Duration", value: viewStore.binding(keyPath: \.windowOpacityDuration, send: keyPath))
//                            SpecialTextFieldFloats(title: "Active Window Opacity",   value: viewStore.binding(keyPath: \.activeWindowOpacity,   send: keyPath))
//                            SpecialTextFieldFloats(title: "Normal Window Opacity",   value: viewStore.binding(keyPath: \.normalWindowOpacity,   send: keyPath))
//                        }
//                        SectionView("Window Borders") {
//                            Toggle("Window Border", isOn: viewStore.binding(keyPath: \.windowBorder, send: keyPath))
//                            SpecialTextField(       title: "Window Border Width",        value: viewStore.binding(keyPath: \.windowBorderWidth,       send: keyPath))
//                            SpecialTextFieldStrings(title: "Active Window Border Color", value: viewStore.binding(keyPath: \.activeWindowBorderColor, send: keyPath))
//                            SpecialTextFieldStrings(title: "Normal Window Border Color", value: viewStore.binding(keyPath: \.normalWindowBorderColor, send: keyPath))
//                        }
//                        SectionView("Misc") {
//                            SpecialTextFieldStrings(title: "Insert Feedback Color", value: viewStore.binding(keyPath: \.insertFeedbackColor, send: keyPath))
//                            SpecialTextFieldFloats( title: "Split Ratio",           value: viewStore.binding(keyPath: \.splitRatio,          send: keyPath))
//                            Toggle("autoBalance", isOn: viewStore.binding(keyPath: \.autoBalance, send: keyPath))
//                        }
//                        SectionView("Mouse Actions") {
//                            Picker("mouseModifier",   selection: viewStore.binding(keyPath: \.mouseModifier,   send: keyPath)) { ForEach(YabaiSettings.State.MouseModifier.allCases  ) { Text($0.rawValue) } }
//                            Picker("mouseAction1",    selection: viewStore.binding(keyPath: \.mouseAction1,    send: keyPath)) { ForEach(YabaiSettings.State.MouseAction.allCases    ) { Text($0.rawValue) } }
//                            Picker("mouseAction2",    selection: viewStore.binding(keyPath: \.mouseAction2,    send: keyPath)) { ForEach(YabaiSettings.State.MouseAction.allCases    ) { Text($0.rawValue) } }
//                            Picker("mouseDropAction", selection: viewStore.binding(keyPath: \.mouseDropAction, send: keyPath)) { ForEach(YabaiSettings.State.MouseDropAction.allCases) { Text($0.rawValue) } }
//                        }
                        SectionView("Space Settings") {
                            Picker("Layout", selection: viewStore.binding(keyPath: \.layout, send: keyPath)) { ForEach(YabaiSettings.State.Layout.allCases) { Text($0.rawValue) } }
                            SpecialTextField(title: "Top Padding",    value: viewStore.binding(keyPath: \.paddingTop,    send: keyPath))
                            SpecialTextField(title: "Bottom Padding", value: viewStore.binding(keyPath: \.paddingBottom, send: keyPath))
                            SpecialTextField(title: "Left Padding",   value: viewStore.binding(keyPath: \.paddingLeft,   send: keyPath))
                            SpecialTextField(title: "Right Padding",  value: viewStore.binding(keyPath: \.paddingRight,  send: keyPath))
                            SpecialTextField(title: "Window Gap",     value: viewStore.binding(keyPath: \.windowGap,     send: keyPath))
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


// MARK:- SectionView

struct SectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        Section {
            VStack(alignment: .leading) {
                Text(title).fontWeight(.bold)
                Divider()
                content
            }
            .padding()
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView("Title") {
            Picker("View A", selection: .constant("Breakfast")) {
                ForEach(["Breakfast", "Lunch", "Dinner"], id: \.self) {
                    Text($0)
                }
            }
            HStack {
                Text("View B")
                TextField("", text: .constant("25"))
            }
        }
    }
}

// MARK:- SpecialTextField

struct SpecialTextField: View {
    let title: String
    let formatter: Formatter = NumberFormatter()
    @Binding var value: Int
    
    var body: some View {
        HStack {
            Text(title)
            TextField("", value: $value, formatter: formatter)
        }
    }
}

struct SpecialTextFieldStrings: View {
    let title: String
    @Binding var value: String
    
    var body: some View {
        HStack {
            Text(title)
            TextField("", text: $value)
        }
    }
}

struct SpecialTextFieldFloats: View {
    let title: String
    let formatter: Formatter = NumberFormatter()
    @Binding var value: Float
    
    var body: some View {
        HStack {
            Text(title)
            TextField("", value: $value, formatter: formatter)
        }
    }
}

struct SpecialTextField_Previews: PreviewProvider {
    static var previews: some View {
        SpecialTextField(title: "Value", value: .constant(64))
    }
}
