//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture
import KeyboardShortcuts

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
                    
                    HStack {
                        GroupBox {
                            VStack {
                                Text("Normal")
                                    .bold().font(.title3)
                                
                                Button(action: {}) {
                                    Rectangle()
                                        .overlay(Text("Float"))
                                }
                                //.frame(width: 800/4, height: 600/4)
                                .buttonStyle(PlainButtonStyle())
                                
                                KeyboardShortcuts.Recorder(for: .toggleFloating)
                            }
                            .padding(2)
                        }
                        GroupBox {
                            VStack {
                                Text("Tiling")
                                    .bold().font(.title3)
                                
                                Button(action: {}) {
                                    Rectangle()
                                        .overlay(Text("Tiling"))
                                }
                                //.frame(width: 800/4, height: 600/4)
                                .buttonStyle(PlainButtonStyle())
                                
                                KeyboardShortcuts.Recorder(for: .toggleBSP)
                            }
                            .padding(2)
                        }
                        GroupBox {
                            VStack {
                                Text("Stacking")
                                    .bold().font(.title3)
                                
                                Button(action: {}) {
                                    Rectangle()
                                        .overlay(Text("Stacking"))
                                }
                                //.frame(width: 800/4, height: 600/4)
                                .buttonStyle(PlainButtonStyle())
                                
                                KeyboardShortcuts.Recorder(for: .toggleStacking)
                            }
                            .padding(2)
                        }
                    }
                }
                
                // Padding
                VStack(alignment: .leading) {
                    Divider()
                    Text("Padding")
                        .bold().font(.title3)
                    
                    Text("Add padding between windows for Tiling & Stacking layouts")
                        .foregroundColor(Color(.gray))
                    
                    
                    HStack {
                        StepperTextfield("Top",    vs.binding(\.paddingTop, k))
                        StepperTextfield("Bottom", vs.binding(\.paddingBottom, k))
                        StepperTextfield("Left",   vs.binding(\.paddingLeft, k))
                        StepperTextfield("Right",  vs.binding(\.paddingRight, k))
                        StepperTextfield("Gaps",   vs.binding(\.windowGap, k))
                    }
                    KBShortcut(for: .toggleGaps)
                    KBShortcut(for: .togglePadding)
                }

                    
                VStack(alignment: .leading) {
                    Divider()
                    Text("Shortcuts")
                        .bold().font(.title3)

                    KBShortcut(for: .restartYabai)
                    
                    VStack(alignment: .leading) {
                        Divider()
                        Text("Toggles")
                            .bold().font(.title3)
                        KBShortcut(for: .toggleSplit)
                        KBShortcut(for: .toggleBalance)
                    }
                    
                    VStack(alignment: .leading) {
                        Divider()
                        Text("Focus")
                            .bold().font(.title3)
                        KBShortcut(for: .focusNorth)
                        KBShortcut(for: .focusSouth)
                        KBShortcut(for: .focusEast)
                        KBShortcut(for: .focusWest)
                    }
                    
                    VStack(alignment: .leading) {
                        Divider()
                        Text("Resize")
                            .bold().font(.title3)
                        KBShortcut(for: .resizeTop)
                        KBShortcut(for: .resizeBottom)
                        KBShortcut(for: .resizeRight)
                        KBShortcut(for: .resizeLeft)
                    }
                    
                    VStack(alignment: .leading) {
                        Divider()
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


