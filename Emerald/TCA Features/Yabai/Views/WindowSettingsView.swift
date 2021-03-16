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
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    GroupBox {
                        VStack {
                            Text("Active")
                                .bold().font(.title3)
                            
                            Button(action: {}) {
                                Rectangle()
                                    .overlay(Text("Active"))
                            }
                            //.frame(width: 800/4, height: 600/4)
                            .buttonStyle(PlainButtonStyle())
                            
                            Text(Yabai.State.Layout.float.caseDescription)
                                .foregroundColor(Color(.gray))
                            KeyboardShortcuts.Recorder(for: .toggleFloating)
                        }
                        .padding(2)
                    }
                    GroupBox {
                        VStack {
                            Text("Normal")
                                .bold().font(.title3)
                            
                            Button(action: {}) {
                                Rectangle()
                                    .overlay(Text("Normal"))
                            }
                            //.frame(width: 800/4, height: 600/4)
                            .buttonStyle(PlainButtonStyle())
                            
                            Text(Yabai.State.Layout.bsp.caseDescription)
                                .foregroundColor(Color(.gray))
                            KeyboardShortcuts.Recorder(for: .toggleBSP)
                        }
                        .padding(2)
                    }

                }
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
                        StepperTextfield("Width", vs.binding(\.windowBorderWidth, k))
                        ColorPickerView("Focused", vs.binding(\.activeWindowBorderColor, k))
                        ColorPickerView("Normal",  vs.binding(\.normalWindowBorderColor, k))
                        ColorPickerView("Insert",  vs.binding(\.insertWindowBorderColor, k))
                    }
                    .disabled(!vs.windowBorder || vs.sipEnabled)
                    .opacity( !vs.windowBorder || vs.sipEnabled ? 0.5 : 1.0)
                    
                    Text("Draw a border around windows")
                        .foregroundColor(Color(.gray))
                        .disabled(!vs.windowBorder || vs.sipEnabled)
                        .opacity( !vs.windowBorder || vs.sipEnabled ? 0.5 : 1.0)
                }
                
                // Disable Shadows
                Divider()
                VStack(alignment: .leading) {
                    HStack {
                        Group {
                            Toggle("", isOn: vs.binding(\.disableShadows, k))
                                .labelsHidden()
                            
                            Text("Disable Shadows")
                                .bold().font(.title3)
                                .disabled(vs.sipEnabled)
                                .opacity( vs.sipEnabled ? 0.5 : 1.0)
                        }
                        .disabled(vs.sipEnabled)
                        .opacity( vs.sipEnabled ? 0.5 : 1.0)
                        
                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
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
                    .disabled(!vs.disableShadows || vs.sipEnabled)
                    .opacity( !vs.disableShadows || vs.sipEnabled ? 0.5 : 1.0)
                    
                    Text(vs.windowShadow.caseDescription)
                        .foregroundColor(Color(.gray))
                        .disabled(!vs.disableShadows || vs.sipEnabled)
                        .opacity( !vs.disableShadows || vs.sipEnabled ? 0.5 : 1.0)
                }
                
                // Opacity Effects
                Divider()
                VStack(alignment: .leading) {
                    HStack {
                        Group {
                            Toggle("", isOn: vs.binding(\.windowOpacity, k))
                                .labelsHidden()
                            
                            Text("Opacity Effects")
                                .bold().font(.title3)
                        }
                        .disabled(vs.sipEnabled)
                        .opacity( vs.sipEnabled ? 0.5 : 1.0)
                        
                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    
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
                        Text("Change window opacity")
                            .foregroundColor(Color(.gray))
                            .opacity( vs.sipEnabled ? 0.5 : 1.0)
                    }
                    .disabled(!vs.windowOpacity || vs.sipEnabled)
                    .opacity( !vs.windowOpacity || vs.sipEnabled ? 0.5 : 1.0)
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






