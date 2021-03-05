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
                VStack(alignment: .leading) {
                    Text("Shadows")
                    Picker("Shadows", selection: viewStore.binding(keyPath: \.windowShadow, send: keyPath)) {
                        ForEach(Yabai.State.WindowShadow.allCases) {
                            Text($0.rawValue)
                        }
                    }.labelsHidden()
                }
                Divider()
                Section(header: Text("Opacity Effects").bold()) {
                    HStack {
                        VStack {
                            Toggle("Opacity Effects", isOn: viewStore.binding(keyPath: \.windowOpacity, send: keyPath)).labelsHidden()
                            Text("")
                        }
                        Group {
                            VStack(alignment: .leading) {
                                Slider(value: viewStore.binding(keyPath: \.windowOpacityDuration, send: keyPath), in: 0.0...1.0)
                                Text("Animation Duration \(Int(viewStore.windowOpacityDuration * 100))%")
                            }
                            
                            VStack(alignment: .leading) {
                                Slider(value: viewStore.binding(keyPath: \.activeWindowOpacity, send: keyPath), in: 0.0...1.0)
                                Text("Focused Window \(Int(viewStore.activeWindowOpacity * 100))%")
                            }
                            VStack(alignment: .leading) {
                                Slider(value: viewStore.binding(keyPath: \.normalWindowOpacity, send: keyPath), in: 0.0...1.0)
                                Text("Normal Windows \(Int(viewStore.normalWindowOpacity * 100))%")
                            }
                        }.disabled(!viewStore.windowOpacity)
                    }
                }
                Divider()
                Section(header: Text("Borders").bold()) {
                    HStack {
                        VStack {
                            Toggle("Borders", isOn: viewStore.binding(keyPath: \.windowBorder, send: keyPath)).labelsHidden()
                            Text("")
                        }
                        
                        Group {
                            VStack {
                                HStack {
                                    Text("\(viewStore.windowBorderWidth)")
                                    Spacer()
                                    Stepper("", value: viewStore.binding(keyPath: \.windowBorderWidth, send: keyPath), in: 0...10)
                                }
                                .frame(width: 60)
                                .background(Color.black.opacity(0.25))
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                                Text("Width")
                            }
                            VStack {
                                ColorPicker("Focused", selection: viewStore.binding(get: \.activeWindowBorderColor.color, send: Yabai.Action.updateActiveWindowBorderColor)).labelsHidden()
                                Text("Focused")
                            }
                            VStack {
                                ColorPicker("Normal", selection: viewStore.binding(get: \.normalWindowBorderColor.color, send: Yabai.Action.updateNormalWindowBorderColor)).labelsHidden()
                                Text("Normal")
                            }
                            VStack {
                                ColorPicker("Insert", selection: viewStore.binding(get: \.insertWindowBorderColor.color, send: Yabai.Action.updateInsertWindowBorderColor)).labelsHidden()
                                Text("Insert")
                            }
                        }
                        .disabled(!viewStore.windowBorder)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Placement")
                        Picker("Placement", selection: viewStore.binding(keyPath: \.windowPlacement, send: keyPath)) {
                            ForEach(Yabai.State.WindowPlacement.allCases) {
                                Text($0.rawValue)
                            }
                        }.labelsHidden()
                    }
                    Toggle("Floating Windows Stay-On-Top", isOn: viewStore.binding(keyPath: \.windowTopmost, send: keyPath))
                    Toggle("Auto Balance", isOn: viewStore.binding(keyPath: \.autoBalance, send: keyPath))
                    SpecialTextFieldFloats(title: "Split Ratio", value: viewStore.binding(keyPath: \.splitRatio, send: keyPath)).disabled(viewStore.autoBalance)
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
