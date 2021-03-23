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
                VStack(spacing: 30) {
                    HStack {
                        Text("Window")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    Divider()
                    HStack {
                        VStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .opacity(Double(viewStore.activeWindowOpacity))
                                        .border(viewStore.activeWindowBorderColor.color, width: CGFloat(viewStore.windowBorderWidth/2))
                                        .foregroundColor(Color(.controlBackgroundColor))
                                        .overlay(Text("Focus").foregroundColor(.gray))
                                    
                                    VStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .opacity(Double(viewStore.normalWindowOpacity))
                                            .border(viewStore.normalWindowBorderColor.color, width: CGFloat(viewStore.windowBorderWidth/2))
                                            .foregroundColor(Color(.controlBackgroundColor))
                                            .overlay(Text("Normal").foregroundColor(.gray))
                                        RoundedRectangle(cornerRadius: 10)
                                            .opacity(Double(viewStore.normalWindowOpacity))
                                            .border(viewStore.normalWindowBorderColor.color, width: CGFloat(viewStore.windowBorderWidth/2))
                                            .foregroundColor(Color(.controlBackgroundColor))
                                            .overlay(Text("Normal").foregroundColor(.gray))
                                    }
                                }
                                .padding()
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                                .background(Color(.windowBackgroundColor))
                                
                                
                                HStack {
                                    //Active/Focused
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Border")
                                            ColorPicker("", selection: viewStore.binding(keyPath: \.activeWindowBorderColor.color, send: Yabai.Action.keyPath))
                                                .labelsHidden()
                                            
                                            ForEach([Color.blue, .purple, .pink, .red, .orange, .yellow, .green, .gray], id: \.self) { color in
                                                Button(action: { viewStore.send(.updateActiveWindowBorderColor(color))}) {
                                                    Circle()
                                                        .overlay(
                                                            Circle()
                                                                .foregroundColor(.white)
                                                                .frame(width: 6)
                                                                .opacity(viewStore.activeWindowBorderColor.color == color ? 1 : 0)
                                                        )
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                                .frame(width: 16)
                                                .foregroundColor(color)
                                            }
                                        }
                                        HStack {
                                            Text("Opacity")
                                            Slider(value: viewStore.binding(keyPath: \.activeWindowOpacity, send: Yabai.Action.keyPath))
                                        }
                                    }
                                    //Normal
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Border")
                                            ColorPicker("", selection: viewStore.binding(keyPath: \.normalWindowBorderColor.color, send: Yabai.Action.keyPath))
                                                .labelsHidden()
                                            
                                            ForEach([Color.blue, .purple, .pink, .red, .orange, .yellow, .green, .gray], id: \.self) { color in
                                                Button(action: { viewStore.send(.updateNormalWindowBorderColor(color))}) {
                                                    Circle()
                                                        .overlay(
                                                            Circle()
                                                                .foregroundColor(.white)
                                                                .frame(width: 6)
                                                                .opacity(viewStore.normalWindowBorderColor.color == color ? 1 : 0)
                                                        )
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                                .frame(width: 16)
                                                .foregroundColor(color)
                                            }
                                        }
                                        
                                        HStack {
                                            Text("Opacity")
                                            Slider(value: viewStore.binding(keyPath: \.normalWindowOpacity, send: Yabai.Action.keyPath))
                                        }
                                    }
                                }
                            }
                        }
                    }
                    HStack {
                        Text("Border Width")
                        Slider(value: viewStore.binding(get: \.windowBorderWidth, send: Yabai.Action.updateWindowBorderWidth), in: 0...30)
                    }
                }
                // Disable Shadows
                Divider()
                VStack(alignment: .leading, spacing: 30) {
                    HStack {
                        Text("Shadows")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
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






