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
                VStack(alignment: .leading) {
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
                    
                    KBShortcut(for: .restartYabai)
                    
                    VStack(alignment: .leading) {
                        Text("Layout")
                            .bold().font(.title3)
                        KBShortcut(for: .toggleFloating)
                        KBShortcut(for: .toggleBSP)
                        KBShortcut(for: .toggleStacking)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Toggles")
                            .bold().font(.title3)
                        KBShortcut(for: .togglePadding)
                        KBShortcut(for: .toggleGaps)
                        KBShortcut(for: .toggleSplit)
                        KBShortcut(for: .toggleBalance)
                    }

                    VStack(alignment: .leading) {
                        Text("Focus")
                            .bold().font(.title3)
                        KBShortcut(for: .focusNorth)
                        KBShortcut(for: .focusSouth)
                        KBShortcut(for: .focusEast)
                        KBShortcut(for: .focusWest)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Resize")
                            .bold().font(.title3)
                        KBShortcut(for: .resizeTop)
                        KBShortcut(for: .resizeBottom)
                        KBShortcut(for: .resizeRight)
                        KBShortcut(for: .resizeLeft)
                    }

                    VStack(alignment: .leading) {
                        Text("Move")
                            .bold().font(.title3)
                        KBShortcut(for: .moveNorth)
                        KBShortcut(for: .moveSouth)
                        KBShortcut(for: .moveEast)
                        KBShortcut(for: .moveWest)
                    }
                                        
                    
                    Text(vs.layout.caseDescription)
                        .foregroundColor(Color(.gray))
                }
                
                // Padding
                VStack(alignment: .leading) {
                    Divider()
                    Text("Padding")
                        .bold().font(.title3)
                    
                    HStack {
                        StepperTextfield("Top",    vs.binding(\.paddingTop, k))
                        StepperTextfield("Bottom", vs.binding(\.paddingBottom, k))
                        StepperTextfield("Left",   vs.binding(\.paddingLeft, k))
                        StepperTextfield("Right",  vs.binding(\.paddingRight, k))
                        StepperTextfield("Gaps",   vs.binding(\.windowGap, k))
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


