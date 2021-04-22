//
//  WindowSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture
import KeyboardShortcuts

struct WindowSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Window")
                        .font(.largeTitle)
                        .bold()
                    Divider()
                    
                    HStack {
                        Window2(
                            opacity: vs.activeWindowOpacity,
                            borderColor: vs.activeWindowBorderColor.color,
                            borderWidth: CGFloat(vs.windowBorderWidth)
                        )
                        .frame(height: 100)
                        
                        Window2(
                            opacity: vs.normalWindowOpacity,
                            borderColor: vs.normalWindowBorderColor.color,
                            borderWidth: CGFloat(vs.windowBorderWidth)
                        )
                        .frame(height: 100)
                    }
                    
                    
                    SectionView("Window") {
                        
                        Section(header: Text("Disable Shadows").bold()) {
                            HStack {
                                Toggle("Enabled", isOn: vs.binding(keyPath: \.disableShadows, send: k)).labelsHidden()
                                
                                Picker("", selection: vs.binding(keyPath: \.windowShadow, send: k)) {
                                    ForEach(Yabai.State.WindowShadow.allCases) {
                                        Text($0.labelDescription.lowercased())
                                    }
                                }
                                .labelsHidden()
                                .pickerStyle(SegmentedPickerStyle())
                                .frame(width: 150)
                                .disabled(!vs.disableShadows)
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
            .frame(maxWidth: 1200)
            .padding()
            .navigationTitle("")
        }
    }
}

// MARK:- SwiftUI_Previews
struct WindowSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        WindowSettingsView(store: Yabai.defaultStore)
    }
}

//MARK:--
struct OpacitySettings: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            Section(header:
                        HStack {
                            Toggle(
                                "Opacity Effects",
                                isOn: .constant(true)//vs.binding(keyPath: \.windowOpacity, send: k)
                            )
                            .labelsHidden()
                            Text("Opacity Effects").bold()
                        }
            ) {
                //                VStack(alignment: .leading) {
                //                    Group {
                //                        SliderView(
                //                            text: "Animation Duration",
                //                            value: vs.binding(
                //                                get: \.windowOpacityDuration,
                //                                send: Yabai.Action.updateWindowOpacityDuration
                //                            ),
                //                            isEnabled: vs.windowOpacity
                //                        )
                //                        SliderView(
                //                            text: "Focused Window",
                //                            value: vs.binding(
                //                                get: \.activeWindowOpacity,
                //                                send: Yabai.Action.updatetActiveWindowOpacity
                //                            ),
                //                            isEnabled: vs.windowOpacity
                //                        )
                //                        SliderView(
                //                            text: "Normal Windows",
                //                            value: vs.binding(
                //                                get: \.normalWindowOpacity,
                //                                send: Yabai.Action.updateNormalWindowOpacity
                //                            ),
                //                            isEnabled: vs.windowOpacity
                //                        )
                //                    }
                //                }
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
                //                HStack {
                //                    VStack {
                //                        Toggle(
                //                            "Borders",
                //                            isOn: vs.binding(keyPath: \.windowBorder, send: k)
                //                        )
                //                        .labelsHidden()
                //                        Text("")
                //                    }
                //                    Group {
                //                        StepperView(
                //                            text: "Width",
                //                            value: vs.binding(keyPath: \.windowBorderWidth, send: k),
                //                            isEnabled: vs.windowBorder
                //                        )
                //                        ColorPickerView(
                //                            text: "Focused",
                //                            selection: vs.binding(
                //                                get: \.activeWindowBorderColor.color,
                //                                send: Yabai.Action.updateActiveWindowBorderColor
                //                            )
                //                        )
                //                        ColorPickerView(
                //                            text: "Normal",
                //                            selection: vs.binding(
                //                                get: \.normalWindowBorderColor.color,
                //                                send: Yabai.Action.updateNormalWindowBorderColor
                //                            )
                //                        )
                //                        ColorPickerView(
                //                            text: "Insert",
                //                            selection: vs.binding(
                //                                get: \.insertWindowBorderColor.color,
                //                                send: Yabai.Action.updateInsertWindowBorderColor
                //                            )
                //                        )
                //                    }
                //                    .disabled(!vs.windowBorder)
                //                }
                Divider()
                Section(header: Text("New Window").bold()) {
                    Picker("", selection: vs.binding(keyPath: \.windowPlacement, send: k)) {
                        ForEach(Yabai.State.WindowPlacement.allCases) {
                            Text($0.labelDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                }
                Divider()
                Section(header: Text("Split Ratio").bold()) {
                    HStack {
                        Picker("", selection: vs.binding(keyPath: \.windowBalance, send: k)) {
                            ForEach(Yabai.State.WindowBalance.allCases) {
                                Text($0.labelDescription.lowercased())
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 200)
                        
                        //                        SliderView(
                        //                            text: "Custom",
                        //                            value: vs.binding(keyPath: \.splitRatio, send: k),
                        //                            isEnabled: vs.windowBalance == .custom,
                        //                            hideLabel: true
                        //                        )
                    }
                }
                Divider()
                Section(header: Text("Float-On-Top").bold()) {
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



//struct WindowSettingsView: View {
//    let store: Store<Yabai.State, Yabai.Action>
//
//    var body: some View {
//        WithViewStore(store) { viewStore in
//            ScrollView {
//                VStack(spacing: 30) {
//                    HStack {
//                        Text("Window")
//                            .font(.largeTitle)
//                            .bold()
//                        Spacer()
//                    }
//                    Divider()
//
//
//                    VStack(alignment: .leading) {
//                        Window2(
//                            opacity: viewStore.activeWindowOpacity,
//                            borderColor: viewStore.activeWindowBorderColor.color,
//                            borderWidth: CGFloat(viewStore.windowBorderWidth)
//                        )
//                        .frame(height: 100)
//
//                        ColorList(
//                            color: viewStore.binding(keyPath: \.activeWindowBorderColor.color, send: Yabai.Action.keyPath),
//                            action: {},// viewStore.send(.updateActiveWindowBorderColor(color)),
//                            opacity: viewStore.binding(keyPath: \.activeWindowOpacity, send: Yabai.Action.keyPath)
//                        )
//
//                        SectionView("Active") {
//
//                        }
//                    }
//                }
//
//                Divider()
//                VStack(alignment: .leading, spacing: 30) {
//                    HStack {
//                        Text("Shadows")
//                            .font(.title)
//                            .bold()
//                        Spacer()
//                    }
//                    HStack {
//                        Group {
//                            Toggle("", isOn: viewStore.binding(keyPath: \.disableShadows, send: Yabai.Action.keyPath))
//                                .labelsHidden()
//
//                            Text("Disable Shadows")
//                                .bold().font(.title3)
//                                .disabled(viewStore.sipEnabled)
//                                .opacity( viewStore.sipEnabled ? 0.5 : 1.0)
//                        }
//                        .disabled(viewStore.sipEnabled)
//                        .opacity( viewStore.sipEnabled ? 0.5 : 1.0)
//
//                        Spacer()
//                        SIPButton(store: Root.defaultStore)
//                    }
//                    HStack {
//                        Picker("", selection: viewStore.binding(keyPath: \.windowShadow, send: Yabai.Action.keyPath)) {
//                            ForEach(Yabai.State.WindowShadow.allCases) {
//                                Text($0.labelDescription.lowercased())
//                            }
//                        }
//                        .labelsHidden()
//                        .pickerStyle(SegmentedPickerStyle())
//                        .frame(width: 150)
//                        .disabled(!viewStore.disableShadows)
//                    }
//                    .disabled(!viewStore.disableShadows || viewStore.sipEnabled)
//                    .opacity( !viewStore.disableShadows || viewStore.sipEnabled ? 0.5 : 1.0)
//
//                    Text(viewStore.windowShadow.caseDescription)
//                        .foregroundColor(Color(.gray))
//                        .disabled(!viewStore.disableShadows || viewStore.sipEnabled)
//                        .opacity( !viewStore.disableShadows || viewStore.sipEnabled ? 0.5 : 1.0)
//                }
//            }
//            .frame(maxWidth: 1200)
//            .padding(.horizontal, 30)
//            .padding(.vertical)
//            .navigationTitle("")
//        }
//    }
//}
//
private struct Window2: View {
    var opacity: Double
    var borderColor: Color
    var borderWidth: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .opacity(opacity)
            .foregroundColor(
                Color(.controlBackgroundColor)
            )
            .overlay(
                Text("Focus")
                    .foregroundColor(.gray)
                    .opacity(opacity)
            )
            .shadow(radius: 6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray, lineWidth: 0.75)
                    .opacity(opacity)
            )
            .overlay(
                Rectangle()
                    .stroke(borderColor, lineWidth: borderWidth/2)
            )
            .padding()
    }
}
//
//private struct ColorList: View {
//    @Binding var color: Color
//    var action: () -> Void
//    @Binding var opacity: Double
//
//    let colors: [Color] = [.blue, .purple, .pink, .red, .orange, .yellow, .green, .gray]
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Border")
//                ColorPicker("", selection: $color)
//                    .labelsHidden()
//
//                ForEach(colors, id: \.self) { color in
//                    Button(action: action) {
//                        Circle()
//                            .overlay(
//                                Circle()
//                                    .foregroundColor(.white)
//                                    .frame(width: 6)
//                                    .opacity(opacity)
//                            )
//                    }
//                    .buttonStyle(PlainButtonStyle())
//                    .frame(width: 16)
//                    .foregroundColor(color)
//                }
//            }
//            HStack {
//                Text("Opacity")
//                Slider(value: $opacity, in: 0.1...1.0)
//            }
//        }
//    }
//}
//
//// MARK:- SwiftUI_Previews
//struct WindowSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WindowSettingsView(store: Yabai.defaultStore)
//    }
//}
