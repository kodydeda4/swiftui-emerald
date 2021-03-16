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
    
    enum Shortcuts: String, Identifiable, CaseIterable {
        var id: Shortcuts { self }
        case arrows = "Arrows"
        case vim = "Vim"
        case custom = "Custom"
    }
    
    @State var shortcut: Shortcuts = .arrows
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading, spacing: 20) {
                
                // Layout
                VStack(alignment: .leading) {
                    //                    Text("Layout")
                    //                        .bold().font(.title3)
                    
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
                                
                                Text(Yabai.State.Layout.float.caseDescription)
                                    .foregroundColor(Color(.gray))
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
                                
                                Text(Yabai.State.Layout.bsp.caseDescription)
                                    .foregroundColor(Color(.gray))
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
                                
                                Text(Yabai.State.Layout.stack.caseDescription)
                                    .foregroundColor(Color(.gray))
                                KeyboardShortcuts.Recorder(for: .toggleStacking)
                            }
                            .padding(2)
                        }
                    }
                }
                
                // Padding
                Divider()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Gaps")
                            .bold().font(.title3)
                        
                        VStack {
                            HStack {
                                Text("Inner")
                                TextField("", value: vs.binding(\.windowGap, k), formatter: NumberFormatter())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(
                                        HStack {
                                            Spacer()
                                            Stepper("", value: vs.binding(\.windowGap, k), in: 0...30)
                                        }
                                    )

                                    .frame(width: 130)

                                KeyboardShortcuts.Recorder(for: .toggleGaps)
                            }
                            HStack {
                                Text("Outer")
                                TextField("", value: vs.binding(\.padding, k), formatter: NumberFormatter())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(
                                        HStack {
                                            Spacer()
                                            Stepper("", value: vs.binding(\.padding, k), in: 0...30)
                                        }
                                    )

                                    .frame(width: 130)
                                
                                KeyboardShortcuts.Recorder(for: .togglePadding)
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Divider()
                    Text("Shortcuts")
                        .bold().font(.title3)
                    
                    
                    HStack {
                        //                        VStack {
                        //                            Text("Focus")
                        //                            Text("Resize")
                        //                            Text("Move")
                        //                        }
                        VStack {
                            Label("↑", systemImage: "square.tophalf.fill")
                            KeyboardShortcuts.Recorder(for: .focusNorth)
                            KeyboardShortcuts.Recorder(for: .resizeTop)
                            KeyboardShortcuts.Recorder(for: .moveNorth)
                        }
                        VStack {
                            Label("↓", systemImage: "square.bottomhalf.fill")
                            KeyboardShortcuts.Recorder(for: .focusSouth)
                            KeyboardShortcuts.Recorder(for: .resizeBottom)
                            KeyboardShortcuts.Recorder(for: .moveSouth)
                        }
                        VStack {
                            Label("→", systemImage: "square.righthalf.fill")
                            KeyboardShortcuts.Recorder(for: .focusEast)
                            KeyboardShortcuts.Recorder(for: .resizeRight)
                            KeyboardShortcuts.Recorder(for: .moveEast)
                        }
                        VStack {
                            Label("←", systemImage: "square.lefthalf.fill")
                            KeyboardShortcuts.Recorder(for: .focusWest)
                            KeyboardShortcuts.Recorder(for: .resizeLeft)
                            KeyboardShortcuts.Recorder(for: .moveWest)
                        }
                    }
                    
                    
                    Picker("", selection: $shortcut) {
                        ForEach(Shortcuts.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 150)
                    
                    
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
            .navigationTitle("Layout")
        }
    }
}



// MARK:- SwiftUI_Previews
struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Yabai.defaultStore)
    }
}


