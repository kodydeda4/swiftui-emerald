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
<<<<<<< HEAD
            VStack {
                HStack {
                    Text("Layout")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                Divider()
                
                HStack {
                    ForEach(Yabai.State.Layout.allCases) { str in
                        VStack {
                            Button(action: { vs.send(.updateLayout(str)) }) {
                                Rectangle()
                            }
                            .buttonStyle(PlainButtonStyle())
                            .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                            .foregroundColor(vs.layout == str ? .accentColor : .gray)
                            
                            Text(str.labelDescription)
                                .bold().font(.title3)
                            
                            Text(str.caseDescription)
                                .foregroundColor(Color(.gray))
                            
                            KeyboardShortcuts.Recorder(for: .toggleFloating)
                        }
                    }
                }
            }
        }
    }
}

// MARK:- SwiftUI_Previews
struct LayoutButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutButtonsView(store: Yabai.defaultStore)
    }
}



struct GapsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack {
                HStack {
                    Text("Gaps")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                HStack {
//                    ForEach() { str in
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
//                    }
                    
//                    VStack {
//                        Rectangle()
//                            .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
//                            .foregroundColor(.blue)
//
//                        Text("Outer")
//                            .bold()
//                            .font(.title3)
//
//                        Text("Description")
//                            .foregroundColor(Color(.gray))
//
//                        TextField("", value: vs.binding(\.padding, k), formatter: NumberFormatter())
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .overlay(
//                                HStack {
//                                    Spacer()
//                                    Stepper("", value: vs.binding(\.padding, k), in: 0...30)
//                                }
//                            )
//                            .frame(width: 130)
//
//                        KeyboardShortcuts.Recorder(for: .togglePadding)
//                    }
                }
            }
        }
    }
}

// MARK:- SwiftUI_Previews
struct GapsView_Previews: PreviewProvider {
    static var previews: some View {
        GapsView(store: Yabai.defaultStore)
    }
}

struct ShortcutsView: View {
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
                HStack {
                    Text("Shortcuts")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                
                HStack {
                    ForEach(["Focus", "Resize", "Move"], id: \.self) { str in
                        VStack {
                            Rectangle()
                                .foregroundColor(.red)
                                .aspectRatio(
                                    CGSize(width: 16, height: 9),
                                    contentMode: .fit)
                            
                            Text(str)
                                .bold()
                                .font(.title3)
                            
                            Text("⌃ + ARROW")
                                .foregroundColor(Color(.gray))
                        }
                    }
                }
//                HStack {
//                    ForEach(["top", "bottom", "left", "right"], id: \.self) { str in
//                        VStack {
//                            Image(systemName: "square.\(str)half.fill")
//                                .resizable()
//                                .scaledToFit()
//                                .foregroundColor(.red)
//
//                            Text(str)
//                                .bold()
//                                .font(.title3)
//                        }
//                        .padding(.horizontal)
//                    }
//                }
            }
        }
    }
}

// MARK:- SwiftUI_Previews
struct ShortcutsView_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutsView(store: Yabai.defaultStore)
    }
}


struct SpaceSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    
    var body: some View {
        WithViewStore(store) { vs in
            ScrollView {
                LayoutButtonsView(store: store)
                Divider()
                GapsView(store: store)
                Divider()
                ShortcutsView(store: store)
                
=======
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
                                
                                Button(action: { vs.send(.updateLayout(.float)) }) {
                                    Rectangle()
                                        .overlay(Text("Float"))
                                        .foregroundColor(vs.layout == .float ? .accentColor : .gray)
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
                                
                                Button(action: { vs.send(.updateLayout(.bsp)) }) {
                                    Rectangle()
                                        .overlay(Text("Tiling"))
                                        .foregroundColor(vs.layout == .bsp ? .accentColor : .gray)
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
                                
                                Button(action: { vs.send(.updateLayout(.stack)) }) {
                                    Rectangle()
                                        .overlay(Text("Stacking"))
                                        .foregroundColor(vs.layout == .stack ? .accentColor : .gray)
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
                    .frame(width: 500, height: 300)
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
                        VStack(alignment: .leading) {
                            Text("").frame(height: 25)
                            Text("Focus ⌃").frame(height: 25)
                            Text("Resize ⌃⌥").frame(height: 25)
                            Text("Move ⌃⌥⌘").frame(height: 25)
                        }
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
                        Spacer()
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
>>>>>>> parent of d571f47 (added foundation for Layout view)
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


