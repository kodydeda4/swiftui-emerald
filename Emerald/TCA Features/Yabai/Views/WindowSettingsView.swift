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
                VStack(alignment: .leading) {
                    Text("Window")
                        .font(.largeTitle)
                        .bold()
                    Divider()
                    HStack {
                        SectionView("Active") {
                            WindowSettings(
                                color: viewStore.binding(keyPath: \.activeWindowBorderColor.color, send: Yabai.Action.keyPath),
                                opacity: viewStore.binding(keyPath: \.activeWindowOpacity, send: Yabai.Action.keyPath),
                                width: CGFloat(viewStore.windowBorderWidth)
                            )
                        }
                        SectionView("Normal") {
                            WindowSettings(
                                color: viewStore.binding(keyPath: \.normalWindowBorderColor.color, send: Yabai.Action.keyPath),
                                opacity: viewStore.binding(keyPath: \.normalWindowOpacity, send: Yabai.Action.keyPath),
                                width: CGFloat(viewStore.windowBorderWidth)
                            )
                        }
                    }
                }
                SectionView("Misc") {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Border Width")
                            Slider(value: viewStore.binding(get: \.windowBorderWidth, send: Yabai.Action.updateWindowBorderWidth), in: 0...30)
                        }
                        Divider()
                        HStack {
                            Toggle("", isOn: viewStore.binding(keyPath: \.disableShadows, send: Yabai.Action.keyPath))
                                .labelsHidden()
                            
                            Text("Disable Shadows")
                                .bold().font(.title3)
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
                        
                        Divider()
                        HStack {
                            Group {
                                Toggle("", isOn: viewStore.binding(keyPath: \.windowTopmost, send: Yabai.Action.keyPath))
                                    .labelsHidden()
                                
                                Text("Float-On-Top")
                                    .bold().font(.title3)
                            }
                            Spacer()
                        }
                        Text("Force floating windows to stay ontop of tiled/stacked windows")
                            .foregroundColor(Color(.gray))

                    }
                }
            }
            .frame(maxWidth: 1200)
            .padding()
            .navigationTitle("")
        }
    }
}



private struct WindowSettings: View {
    @Binding var color: Color
    @Binding var opacity: Double
    var width: CGFloat
    
    let colors: [Color] = [.blue, .purple, .pink, .red, .orange, .yellow, .green, .gray]
    
    var body: some View {
        VStack {
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
                        .stroke(color, lineWidth: width/2)
                )
                .padding()
                
                .frame(height: 200)
            
            HStack {
                Text("Border")
                ColorPicker("", selection: $color)
                    .labelsHidden()
                
                ForEach(colors, id: \.self) { color in
                    Button(action: {}) {
                        Circle()
                            .overlay(
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: 6)
                                    .opacity(opacity)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 16)
                    .foregroundColor(color)
                }
            }
            HStack {
                Text("Opacity")
                Slider(value: $opacity, in: 0.1...1.0)
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






