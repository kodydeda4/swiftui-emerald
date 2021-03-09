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
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack {
                Text("Window").font(.title)
                
                // Disable Shadows
                VStack {
                    Text("Disable Shadows").bold()
                    HStack {
                        Toggle("Enabled", isOn: vs.binding(keyPath: \.disableShadows, send: k)).labelsHidden()
                        
                        Picker("", selection: vs.binding(keyPath: \.windowShadow, send: k)) {
                            ForEach(Yabai.State.WindowShadow.allCases) {
                                Text($0.uiDescription.lowercased())
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 150)
                        .disabled(!vs.disableShadows)
                    }
                }
                
                // Opacity Effects
                VStack {
                    HStack {
                        Toggle("Opacity Effects", isOn: vs.binding(keyPath: \.windowOpacity, send: k))
                            .labelsHidden()
                        Text("Opacity Effects").bold()
                    }
                    VStack(alignment: .leading) {
                        Slider(
                            value: vs.binding(
                                keyPath: \.windowOpacityDuration,
                                send: k
                            )
                        )
                        Slider(
                            value: vs.binding(
                                keyPath: \.activeWindowOpacity,
                                send: k
                            )
                        )

                        Slider(
                            value: vs.binding(
                                keyPath: \.normalWindowOpacity,
                                send: k
                            )
                        )
                    }
                }
                
                // Borders
                VStack {
                    Text("Borders").bold()
                    HStack {
                        Toggle("Borders", isOn: vs.binding(keyPath: \.windowBorder, send: k))
                            .labelsHidden()
                        
                        HStack {
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






