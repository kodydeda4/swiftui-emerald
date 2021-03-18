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
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                HStack {
                    Text("Window")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                Divider()
                
                HStack {
                    ForEach(["Active", "Normal"], id: \.self) { str in
                        VStack {
                            Rectangle()
                                .foregroundColor(.red)
                                .aspectRatio(
                                    CGSize(width: 16, height: 9),
                                    contentMode: .fit)
                            
                            Text(str)
                                .bold()
                                .font(.title3)
                        }
                    }
                }
                // Borders
                VStack(alignment: .leading) {
                    HStack {
                        Group {
                            Toggle("", isOn: viewStore.binding(keyPath: \.windowBorder, send: Yabai.Action.keyPath))
                                .labelsHidden()
                            
                            Text("Borders")
                                .bold().font(.title3)
                        }
                        .disabled(viewStore.sipEnabled)
                        .opacity( viewStore.sipEnabled ? 0.5 : 1.0)
                        
                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    HStack {
                        StepperTextfield("Width", viewStore.binding(keyPath: \.windowBorderWidth, send: Yabai.Action.keyPath))
                        ColorPickerView("Focused", viewStore.binding(keyPath: \.activeWindowBorderColor, send: Yabai.Action.keyPath))
                        ColorPickerView("Normal",  viewStore.binding(keyPath: \.normalWindowBorderColor, send: Yabai.Action.keyPath))
                        ColorPickerView("Insert",  viewStore.binding(keyPath: \.insertWindowBorderColor, send: Yabai.Action.keyPath))
                    }
                    .disabled(!viewStore.windowBorder || viewStore.sipEnabled)
                    .opacity( !viewStore.windowBorder || viewStore.sipEnabled ? 0.5 : 1.0)
                    
                    Text("Draw a border around windows")
                        .foregroundColor(Color(.gray))
                        .disabled(!viewStore.windowBorder || viewStore.sipEnabled)
                        .opacity( !viewStore.windowBorder || viewStore.sipEnabled ? 0.5 : 1.0)
                }
                
                // Disable Shadows
                Divider()
                VStack(alignment: .leading) {
                    HStack {
                        Group {
                            Toggle("", isOn: viewStore.binding(keyPath: \.disableShadows, send: Yabai.Action.keyPath))
                                .labelsHidden()
                            
                            Text("Disable Shadows")
                                .bold().font(.title3)
                                .disabled(viewStore.sipEnabled)
                                .opacity( viewStore.sipEnabled ? 0.5 : 1.0)
                        }
                        .disabled(viewStore.sipEnabled)
                        .opacity( viewStore.sipEnabled ? 0.5 : 1.0)
                        
                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    HStack {
                        Picker("", selection: viewStore.binding(keyPath: \.windowShadow, send: Yabai.Action.keyPath)) {
                            ForEach(Yabai.State.WindowShadow.allCases) {
                                Text($0.labelDescription.lowercased())
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 150)
                        .disabled(!viewStore.disableShadows)
                    }
                    .disabled(!viewStore.disableShadows || viewStore.sipEnabled)
                    .opacity( !viewStore.disableShadows || viewStore.sipEnabled ? 0.5 : 1.0)
                    
                    Text(viewStore.windowShadow.caseDescription)
                        .foregroundColor(Color(.gray))
                        .disabled(!viewStore.disableShadows || viewStore.sipEnabled)
                        .opacity( !viewStore.disableShadows || viewStore.sipEnabled ? 0.5 : 1.0)
                }
                
                // Opacity Effects
                Divider()
                VStack(alignment: .leading) {
                    HStack {
                        Group {
                            Toggle("", isOn: viewStore.binding(keyPath: \.windowOpacity, send: Yabai.Action.keyPath))
                                .labelsHidden()
                            
                            Text("Opacity Effects")
                                .bold().font(.title3)
                        }
                        .disabled(viewStore.sipEnabled)
                        .opacity( viewStore.sipEnabled ? 0.5 : 1.0)
                        
                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Animation Duration").foregroundColor(Color(.gray))
                            Slider(value: viewStore.binding(keyPath: \.windowOpacityDuration, send: Yabai.Action.keyPath))
                        }
                        VStack(alignment: .leading) {
                            Text("Active Windows").foregroundColor(Color(.gray))
                            Slider(value: viewStore.binding(keyPath: \.activeWindowOpacity, send: Yabai.Action.keyPath))
                        }
                        VStack(alignment: .leading) {
                            Text("Normal Windows").foregroundColor(Color(.gray))
                            Slider(value: viewStore.binding(keyPath: \.normalWindowOpacity, send: Yabai.Action.keyPath))
                        }
                        Text("Change window opacity")
                            .foregroundColor(Color(.gray))
                            .opacity( viewStore.sipEnabled ? 0.5 : 1.0)
                    }
                    .disabled(!viewStore.windowOpacity || viewStore.sipEnabled)
                    .opacity( !viewStore.windowOpacity || viewStore.sipEnabled ? 0.5 : 1.0)
                    
                    // Float-On-Top
                    //                VStack(alignment: .leading) {
                    //                    Divider()
                    //                    HStack {
                    //                        Group {
                    //                            Toggle("", isOn: vs.binding(\.windowTopmost, k))
                    //                                .labelsHidden()
                    //
                    //                            Text("Float-On-Top")
                    //                                .bold().font(.title3)
                    //                        }
                    //                        .disabled(vs.sipEnabled || vs.layout == .float)
                    //                        .opacity( vs.sipEnabled || vs.layout == .float ? 0.5 : 1.0)
                    //
                    //                        Spacer()
                    //                        SIPButton(store: Root.defaultStore)
                    //                    }
                    //
                    //                    Text("Force floating windows to stay ontop of tiled/stacked windows")
                    //                        .foregroundColor(Color(.gray))
                    //                        .disabled(vs.sipEnabled || vs.layout == .float)
                    //                        .opacity( vs.sipEnabled || vs.layout == .float ? 0.5 : 1.0)
                    //                }
                    
                }
                Spacer()
            }
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






