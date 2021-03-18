//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture
import KeyboardShortcuts

struct LayoutButtonsView: View {
    let store: Store<Yabai.State, Yabai.Action>
        
    var body: some View {
        WithViewStore(store) { vs in
            // Layout
            VStack {
                HStack {
                    Text("Layout")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                Divider()
                
                HStack {
                    VStack {
                        Button(action: { vs.send(.updateLayout(.float)) }) {
                            Rectangle()
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                                .overlay(Text("Float"))
                                .foregroundColor(vs.layout == .float ? .accentColor : .gray)
                                
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Text("Normal")
                            .bold().font(.title3)
                        
                        Text(Yabai.State.Layout.float.caseDescription)
                            .foregroundColor(Color(.gray))
                        
                        KeyboardShortcuts.Recorder(for: .toggleFloating)
                    }
                    VStack {
                        Button(action: { vs.send(.updateLayout(.bsp)) }) {
                            Rectangle()
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                                .overlay(Text("Tiling"))
                                .foregroundColor(vs.layout == .bsp ? .accentColor : .gray)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Text("Tiling")
                            .bold().font(.title3)
                        
                        Text(Yabai.State.Layout.bsp.caseDescription)
                            .foregroundColor(Color(.gray))
                        
                        KeyboardShortcuts.Recorder(for: .toggleBSP)
                    }
                    VStack {
                        Button(action: { vs.send(.updateLayout(.stack)) }) {
                            Rectangle()
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                                .overlay(Text("Stacking"))
                                .foregroundColor(vs.layout == .stack ? .accentColor : .gray)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Text("Stacking")
                            .bold().font(.title3)
                        
                        Text(Yabai.State.Layout.stack.caseDescription)
                            .foregroundColor(Color(.gray))
                        
                        KeyboardShortcuts.Recorder(for: .toggleStacking)
                    }
                }
            }
        }
    }
}






struct SpaceSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    enum Shortcuts: String, Identifiable, CaseIterable {
        var id: Shortcuts { self }
        case arrows = "Arrows"
        case vim = "Vim"
    }
    
    @State var shortcut: Shortcuts = .arrows
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack {
                
                LayoutButtonsView(store: store)
                Divider()
                VStack {
                    HStack {
                        Text("Gaps")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    
                    HStack {
                        VStack {
                            Rectangle()
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                                .foregroundColor(.blue)
                            
                            Text("Inner")
                                .bold()
                                .font(.title3)
                            
                            Text("Description")
                                .foregroundColor(Color(.gray))

                            
                            TextField("", value: vs.binding(\.windowGap, k), formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 130)
                                .overlay(
                                    HStack {
                                        Spacer()
                                        Stepper("", value: vs.binding(\.windowGap, k), in: 0...30)
                                    }
                                )
                            
                            KeyboardShortcuts.Recorder(for: .toggleGaps)
                        }
                        
                        VStack {
                            Rectangle()
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                                .foregroundColor(.red)
                            
                            Text("Outer")
                                .bold()
                                .font(.title3)
                            
                            Text("Description")
                                .foregroundColor(Color(.gray))

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
                VStack {
                    Divider()
                    HStack {
                        Text("Shortcuts")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    

                    HStack {
                        VStack {
                            Rectangle()
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                                .foregroundColor(.red)
                            
                            Text("Focus")
                                .bold()
                                .font(.title3)
                            
                            Text("⌃ + ARROW")
                                .foregroundColor(Color(.gray))
                            
                        }
                        VStack {
                            Rectangle()
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                                .foregroundColor(.red)
                            
                            Text("Move")
                                .bold()
                                .font(.title3)
                            
                            Text("⌃ ⌥ + ARROW")
                                .foregroundColor(Color(.gray))
                            
                        }
                        VStack {
                            Rectangle()
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                                .foregroundColor(.red)
                            
                            Text("Resize")
                                .bold()
                                .font(.title3)
                            
                            Text("⌃ ⌥ ⌘ + ARROW")
                                .foregroundColor(Color(.gray))
                        }
                    }
//                    Picker("", selection: $shortcut) {
//                        ForEach(Shortcuts.allCases) {
//                            Text($0.rawValue)
//                        }
//                    }
//                    .labelsHidden()
//                    .pickerStyle(SegmentedPickerStyle())
//                    .frame(width: 150)
                }

//                VStack {
//                    Divider()
//                    HStack {
//                        Text("Shortcuts")
//                            .font(.title)
//                            .bold()
//                        Spacer()
//                    }
//                    HStack {
//                        VStack {
//                            Text("").frame(height: 25)
//                            Text("Focus ⌃").frame(height: 25)
//                            Text("Resize ⌃⌥").frame(height: 25)
//                            Text("Move ⌃⌥⌘").frame(height: 25)
//                        }
//                        VStack {
//                            Label("↑", systemImage: "square.tophalf.fill")
//                            KeyboardShortcuts.Recorder(for: .focusNorth)
//                            KeyboardShortcuts.Recorder(for: .resizeTop)
//                            KeyboardShortcuts.Recorder(for: .moveNorth)
//                        }
//                        VStack {
//                            Label("↓", systemImage: "square.bottomhalf.fill")
//                            KeyboardShortcuts.Recorder(for: .focusSouth)
//                            KeyboardShortcuts.Recorder(for: .resizeBottom)
//                            KeyboardShortcuts.Recorder(for: .moveSouth)
//                        }
//                        VStack {
//                            Label("→", systemImage: "square.righthalf.fill")
//                            KeyboardShortcuts.Recorder(for: .focusEast)
//                            KeyboardShortcuts.Recorder(for: .resizeRight)
//                            KeyboardShortcuts.Recorder(for: .moveEast)
//                        }
//                        VStack {
//                            Label("←", systemImage: "square.lefthalf.fill")
//                            KeyboardShortcuts.Recorder(for: .focusWest)
//                            KeyboardShortcuts.Recorder(for: .resizeLeft)
//                            KeyboardShortcuts.Recorder(for: .moveWest)
//                        }
//                    }
//                    Picker("", selection: $shortcut) {
//                        ForEach(Shortcuts.allCases) {
//                            Text($0.rawValue)
//                        }
//                    }
//                    .labelsHidden()
//                    .pickerStyle(SegmentedPickerStyle())
//                    .frame(width: 150)
//                }
                Spacer()
            }
            .padding()
            .navigationTitle("")
            //.navigationTitle("Layout")
        }
    }
}



// MARK:- SwiftUI_Previews
struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Yabai.defaultStore)
    }
}


