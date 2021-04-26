//
//  WindowSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

//    # Shadows
//    yabai -m config window_shadow \(!disableShadows ? "on" : windowShadow.rawValue)
//
//    # Opacity Effects
//    yabai -m config window_opacity \(activeWindowOpacity < 1 || normalWindowOpacity < 1 ? "on" : "off")
//    yabai -m config window_opacity_duration \(windowOpacityDuration)
//    yabai -m config active_window_opacity \(activeWindowOpacity)
//    yabai -m config normal_window_opacity \(normalWindowOpacity)
//
//    # Borders
//    yabai -m config window_border \(windowBorderWidth > 0 ? "on" : "off")
//    yabai -m config window_border_width \(Int(windowBorderWidth))
//    yabai -m config active_window_border_color \"\(activeWindowBorderColor.asHexString)\"
//    yabai -m config normal_window_border_color \"\(normalWindowBorderColor.asHexString)\"
//
//    # New Window Placement
//    yabai -m config window_placement \(windowPlacement)
//
//    # Auto Balance
//    yabai -m config auto_balance \(windowBalance == .auto ? "on" : "off")
//
//    # Split Ratio
//    \(windowBalance == .auto ? "#" : "")yabai -m config split_ratio \(windowBalance == .custom ? splitRatio : 0.50)
//
//    # Floating Windows Stay-On-Top
//    yabai -m config window_topmost \(windowTopmost == true ? "on" : "off")
//
//    #============================================
//    # Mouse
//    #============================================
//    # Mouse Follows Focus
//    yabai -m config mouse_follows_focus \(mouseFollowsFocus == true ? "on" : "off")
//
//    # Focus Follows Mouse
//    yabai -m config focus_follows_mouse \(!focusFollowsMouseEnabled ? "off" : "\(focusFollowsMouse)")
//
//    # Modifier Key
//    yabai -m config mouse_modifier \(mouseModifier)
//
//    # Left Click + Modifier
//    yabai -m config mouse_action1 \(mouseAction1)
//
//    # Right Click + Modifier
//    yabai -m config mouse_action2 \(mouseAction2)
//
//    # Drop Action
//    yabai -m config mouse_drop_action \(mouseDropAction)

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
                            VStack {
                                Rectangle()
                                    .frame(height: 20)
                                    .opacity(0.25)
                                
                                HStack {
                                    Window2(
                                        opacity: viewStore.activeWindowOpacity,
                                        borderColor: viewStore.activeWindowBorderColor.color,
                                        borderWidth: CGFloat(viewStore.windowBorderWidth)
                                    )
                                    VStack {
                                        ForEach(0..<2) { _ in
                                            Window2(
                                                opacity: viewStore.normalWindowOpacity,
                                                borderColor: viewStore.normalWindowBorderColor.color,
                                                borderWidth: CGFloat(viewStore.windowBorderWidth)
                                            )
                                        }
                                    }
                                }
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(height: 40)
                                    .opacity(0.25)
                                    .padding()
                            }
                            .aspectRatio(CGSize(width: 16, height: 6), contentMode: .fill)
                            .background(Color(.windowBackgroundColor))
                            
                            
                            HStack {
                                //Active/Focused
                                ColorList(
                                    color: viewStore.binding(keyPath: \.activeWindowBorderColor.color, send: Yabai.Action.keyPath),
                                    action: {},// viewStore.send(.updateActiveWindowBorderColor(color)),
                                    opacity: viewStore.binding(keyPath: \.activeWindowOpacity, send: Yabai.Action.keyPath)
                                    )

                                //Normal
                                ColorList(
                                    color: viewStore.binding(keyPath: \.normalWindowBorderColor.color, send: Yabai.Action.keyPath),
                                    action: {},
                                    opacity: viewStore.binding(keyPath: \.normalWindowOpacity, send: Yabai.Action.keyPath)
                                    )
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
                
            }
            .frame(maxWidth: 1200)
            .padding(.horizontal, 30)
            .padding(.vertical)
            .navigationTitle("")
        }
    }
}

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

private struct ColorList: View {
    @Binding var color: Color
    var action: () -> Void
    @Binding var opacity: Double
    
    let colors: [Color] = [.blue, .purple, .pink, .red, .orange, .yellow, .green, .gray]
     
    var body: some View {
        VStack {
            HStack {
                Text("Border")
                ColorPicker("", selection: $color)
                    .labelsHidden()
                
                ForEach(colors, id: \.self) { color in
                    Button(action: action) {
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






