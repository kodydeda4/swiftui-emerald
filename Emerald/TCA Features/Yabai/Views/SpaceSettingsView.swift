//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture

struct SpaceSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack {
                Text("Space").font(.title)
                
                // Layout
                VStack {
                    Text("Layout").bold()
                    Picker("", selection: vs.binding(keyPath: \.layout, send: k)) {
                        ForEach(Yabai.State.Layout.allCases) {
                            Text($0.uiDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                }
                
                // Padding
                VStack {
                    Text("Padding").bold()
                    HStack {
                        StepperView(
                            text: "Top",
                            value: vs.binding(keyPath: \.paddingTop, send: k),
                            isEnabled: vs.layout != .float
                        )
                        StepperView(
                            text: "Bottom",
                            value: vs.binding(keyPath: \.paddingBottom, send: k),
                            isEnabled: vs.layout != .float
                        )
                        StepperView(
                            text: "Left",
                            value: vs.binding(keyPath: \.paddingLeft, send: k),
                            isEnabled: vs.layout != .float
                        )
                        StepperView(
                            text: "Right",
                            value: vs.binding(keyPath: \.paddingRight, send: k),
                            isEnabled: vs.layout != .float
                        )
                        StepperView(
                            text: "Gaps",
                            value: vs.binding(keyPath: \.windowGap, send: k),
                            isEnabled: vs.layout != .float
                        )
                    }
                }
                
                // New Window
                VStack {
                    Text("New Window").bold()
                    Picker("", selection: vs.binding(keyPath: \.windowPlacement, send: k)) {
                        ForEach(Yabai.State.WindowPlacement.allCases) {
                            Text($0.uiDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                }
                
                // Split Ratio
                VStack {
                    Text("Split Ratio").bold()
                    HStack {
                        Picker("", selection: vs.binding(keyPath: \.windowBalance, send: k)) {
                            ForEach(Yabai.State.WindowBalance.allCases) {
                                Text($0.uiDescription.lowercased())
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 200)
                        
                        Slider(value: vs.binding(keyPath: \.splitRatio, send: k))
                    }
                }
                
                // Float-On-Top
                VStack {
                    Text("Float-On-Top").bold()
                    VStack(alignment: .leading) {
                        HStack {
                            Toggle("Floating Windows Stay-On-Top", isOn: vs.binding(keyPath: \.windowTopmost, send: k))
                                .labelsHidden()
                            Text("Enabled")
                        }
                    }
                }
            }
        }
    }
}


// MARK:- SwiftUI_Previews
struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Yabai.defaultStore)
    }
}
