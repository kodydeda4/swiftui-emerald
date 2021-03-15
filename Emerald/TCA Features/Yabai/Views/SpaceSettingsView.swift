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
            VStack(alignment: .leading, spacing: 20) {
                
                // Layout
                VStack(alignment: .leading, spacing: 20) {
                    Text("Layout")
                        .bold().font(.title3)
                    
                    Picker("", selection: vs.binding(\.layout, k)) {
                        ForEach(Yabai.State.Layout.allCases) {
                            Text($0.labelDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                    
                    KBShortcut(for: .toggleBSP)
                    
                    Text(vs.layout.caseDescription)
                        .foregroundColor(Color(.gray))
                }
                
                // Padding
                VStack(alignment: .leading) {
                    Divider()
                    Text("Padding")
                        .bold().font(.title3)
                    
                    HStack {
                        StepperView("Top",    vs.binding(\.paddingTop, k))
                        StepperView("Bottom", vs.binding(\.paddingBottom, k))
                        StepperView("Left",   vs.binding(\.paddingLeft, k))
                        StepperView("Right",  vs.binding(\.paddingRight, k))
                        StepperView("Gaps",   vs.binding(\.windowGap, k))
                    }
                }
                .disabled(vs.layout == .float)
                .opacity(vs.layout == .float ? 0.5 : 1.0)
                
                // Float-On-Top
                VStack(alignment: .leading) {
                    Divider()
                    HStack {
                        Group {
                            Toggle("", isOn: vs.binding(\.windowTopmost, k))
                                .labelsHidden()
                            
                            Text("Float-On-Top")
                                .bold().font(.title3)
                        }
                        .disabled(vs.sipEnabled || vs.layout == .float)
                        .opacity( vs.sipEnabled || vs.layout == .float ? 0.5 : 1.0)

                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    
                    Text("Force floating windows to stay ontop of tiled/stacked windows")
                        .foregroundColor(Color(.gray))
                        .disabled(vs.sipEnabled || vs.layout == .float)
                        .opacity( vs.sipEnabled || vs.layout == .float ? 0.5 : 1.0)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Space")
        }
    }
}



// MARK:- SwiftUI_Previews
struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Yabai.defaultStore)
    }
}


