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
            VStack(alignment: .leading, spacing: 20) {
                
                // Borders
                VStack(alignment: .leading) {
                    HStack {
                        Group {
                            Toggle("", isOn: vs.binding(\.windowBorder, k))
                                .labelsHidden()
                            
                            Text("Borders")
                                .bold().font(.title3)
                        }
                        .disabled(vs.sipEnabled)
                        .opacity( vs.sipEnabled ? 0.5 : 1.0)
                        
                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    HStack {
                        StepperView("Width", vs.binding(\.windowBorderWidth, k))
                        ColorPickerView("Focused", vs.binding(\.activeWindowBorderColor, k))
                        ColorPickerView("Normal",  vs.binding(\.normalWindowBorderColor, k))
                        ColorPickerView("Insert",  vs.binding(\.insertWindowBorderColor, k))
                    }
                    .disabled(!vs.windowBorder || vs.sipEnabled)
                    .opacity( !vs.windowBorder || vs.sipEnabled ? 0.5 : 1.0)
                    
                    Text("STATIC Description about Borders")
                        .foregroundColor(Color(.gray))
                }
                
                // Disable Shadows
                Divider()
                VStack(alignment: .leading) {
                    HStack {
                        Text("Shadows")
                            .bold().font(.title3)
                            .disabled(vs.sipEnabled)
                            .opacity( vs.sipEnabled ? 0.5 : 1.0)
                        
                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    HStack {
                        Toggle("", isOn: vs.binding(\.disableShadows, k))
                            .labelsHidden()
                        
                        Text("Disable Shadows")
                    }
                    .disabled(vs.sipEnabled)
                    .opacity( vs.sipEnabled ? 0.5 : 1.0)
                    
                    HStack {
                        Picker("", selection: vs.binding(\.windowShadow, k)) {
                            ForEach(Yabai.State.WindowShadow.allCases) {
                                Text($0.labelDescription.lowercased())
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 150)
                        .disabled(!vs.disableShadows)
                    }
                    .disabled(vs.sipEnabled)
                    .opacity( vs.sipEnabled ? 0.5 : 1.0)
                    
                    Text(vs.windowShadow.caseDescription)
                        .foregroundColor(Color(.gray))
                        .disabled(vs.sipEnabled)
                        .opacity( vs.sipEnabled ? 0.5 : 1.0)
                }
                
                // Opacity Effects
                Divider()
                VStack(alignment: .leading) {
                    HStack {
                        Text("Opacity")
                            .bold().font(.title3)
                            .disabled(vs.sipEnabled)
                            .opacity( vs.sipEnabled ? 0.5 : 1.0)
                        
                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    HStack {
                        Toggle("", isOn: vs.binding(\.windowOpacity, k))
                            .labelsHidden()
                        
                        Text("Change Opacity")
                    }
                    .disabled(vs.sipEnabled)
                    .opacity( vs.sipEnabled ? 0.5 : 1.0)
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Animation Duration").foregroundColor(Color(.gray))
                            Slider(value: vs.binding(\.windowOpacityDuration, k))
                        }
                        VStack(alignment: .leading) {
                            Text("Active Windows").foregroundColor(Color(.gray))
                            Slider(value: vs.binding(\.activeWindowOpacity, k))
                        }
                        VStack(alignment: .leading) {
                            Text("Normal Windows").foregroundColor(Color(.gray))
                            Slider(value: vs.binding(\.normalWindowOpacity, k))
                        }
                        Text("STATIC Description about Opacity")
                            .foregroundColor(Color(.gray))
                    }
                    .disabled(vs.sipEnabled)
                    .opacity( vs.sipEnabled ? 0.5 : 1.0)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Space")
        }
    }
}

// MARK:- SwiftUI_Previews
struct WindowSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        WindowSettingsView(store: Yabai.defaultStore)
    }
}






