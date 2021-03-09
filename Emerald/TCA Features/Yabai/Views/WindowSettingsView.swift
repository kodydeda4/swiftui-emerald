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
            HStack {
                settings
                    .padding()
                    .navigationTitle("Window")
                
                Rectangle()
                    .foregroundColor(.black)
            }
        }
    }
}

extension WindowSettingsView {
    var settings: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading, spacing: 20) {
                // Borders
                VStack(alignment: .leading) {
                    HStack {
                        Toggle("", isOn: vs.binding(keyPath: \.windowBorder, send: k))
                            .labelsHidden()
                        Text("Borders").bold().font(.title3)
                    }
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
                    
                    Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                        .foregroundColor(Color(.gray))
                }
                Divider()
                // Disable Shadows
                VStack(alignment: .leading) {
                    Text("Shadows").bold().font(.title3)
                    HStack {
                        Toggle("", isOn: vs.binding(keyPath: \.disableShadows, send: k)).labelsHidden()
                        Text("Disable Shadows")
                    }
                    
                    HStack {
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
                    Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                        .foregroundColor(Color(.gray))
                }
                Divider()
                // Opacity Effects
                VStack(alignment: .leading) {
                    Text("Opacity").bold().font(.title3)

                    HStack {
                        Toggle("", isOn: vs.binding(keyPath: \.windowOpacity, send: k))
                            .labelsHidden()
                        Text("Change Opacity")
                    }
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Animation Duration").foregroundColor(Color(.gray))
                            Slider(
                                value: vs.binding(
                                    keyPath: \.windowOpacityDuration,
                                    send: k
                                )
                            )
                        }
                        VStack(alignment: .leading) {
                            Text("Active Windows").foregroundColor(Color(.gray))
                            Slider(
                                value: vs.binding(
                                    keyPath: \.activeWindowOpacity,
                                    send: k
                                )
                            )
                        }
                        VStack(alignment: .leading) {
                            Text("Normal Windows").foregroundColor(Color(.gray))
                            Slider(
                                value: vs.binding(
                                    keyPath: \.normalWindowOpacity,
                                    send: k
                                )
                            )
                        }
                    }
                    Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                        .foregroundColor(Color(.gray))
                }
                Spacer()
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






