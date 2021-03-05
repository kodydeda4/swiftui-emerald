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
                Section(
                    header:
                        HStack {
                            Toggle("Opacity Effects", isOn: viewStore.binding(keyPath: \.windowOpacity, send: keyPath)).labelsHidden()
                            Text("Opacity Effects")
                        }
                ) {
                    VStack {
                        SpecialTextFieldFloats(title: "Animation Duration", value: viewStore.binding(keyPath: \.windowOpacityDuration, send: keyPath))
                        
                        VStack(alignment: .leading) {
                            Text("Focused Window Opacity \(viewStore.activeWindowOpacity)")
                            Slider(value: viewStore.binding(keyPath: \.activeWindowOpacity, send: keyPath), in: 0.0...1.0)//, step: 0.1)
                        }
                        VStack(alignment: .leading) {
                            Text("Normal Window Opacity \(viewStore.activeWindowOpacity)")
                            Slider(value: viewStore.binding(keyPath: \.normalWindowOpacity, send: keyPath), in: 0.0...1.0)//, step: 0.1)
                        }
                    }.disabled(!viewStore.windowOpacity)
                    
                }
                Divider()
                Section(
                    header:
                        HStack {
                            Toggle("Window Borders", isOn: viewStore.binding(keyPath: \.windowBorder, send: keyPath)).labelsHidden()
                            Text("Window Borders")
                        }
                ) {
                    HStack {
                        Stepper("Width \(viewStore.windowBorderWidth)", value: viewStore.binding(keyPath: \.windowBorderWidth, send: keyPath), in: 0...10)
                            .padding(6)
                            .background(Color.black.opacity(0.25))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        ColorPicker("Focused", selection: viewStore.binding(get: \.activeWindowBorderColor.color, send: Yabai.Action.updateActiveWindowBorderColor))
                        ColorPicker("Normal", selection: viewStore.binding(get: \.normalWindowBorderColor.color, send: Yabai.Action.updateNormalWindowBorderColor))
                        ColorPicker("Insert", selection: viewStore.binding(get: \.insertWindowBorderColor.color, send: Yabai.Action.updateInsertWindowBorderColor))
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

// MARK:- SwiftUI_Previews
struct WindowSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        WindowSettingsView(store: Yabai.defaultStore)
    }
}
