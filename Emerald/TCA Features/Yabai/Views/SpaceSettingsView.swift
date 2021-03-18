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
                        }
                        .buttonStyle(PlainButtonStyle())
                        .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                        .overlay(Text("Float"))
                        .foregroundColor(vs.layout == .float ? .accentColor : .gray)

                        
                        Text("Normal")
                            .bold().font(.title3)
                        
//                        Text(Yabai.State.Layout.float.caseDescription)
//                            .foregroundColor(Color(.gray))
                        
//                        Text("⌃ ⌥ + 1")
//                            .foregroundColor(Color(.gray))

                        KeyboardShortcuts.Recorder(for: .toggleFloating)
                    }
                    VStack {
                        Button(action: { vs.send(.updateLayout(.bsp)) }) {
                            Rectangle()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                        .overlay(Text("Tiling"))
                        .foregroundColor(vs.layout == .bsp ? .accentColor : .gray)

                        
                        Text("Tiling")
                            .bold().font(.title3)
                        
//                        Text(Yabai.State.Layout.bsp.caseDescription)
//                            .foregroundColor(Color(.gray))
                        
//                        Text("⌃ ⌥ + 2")
//                            .foregroundColor(Color(.gray))

                        KeyboardShortcuts.Recorder(for: .toggleBSP)
                    }
                    VStack {
                        Button(action: { vs.send(.updateLayout(.stack)) }) {
                            Rectangle()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                        .overlay(Text("Stacking"))
                        .foregroundColor(vs.layout == .stack ? .accentColor : .gray)
                        
                        Text("Stacking")
                            .bold().font(.title3)
                        
//                        Text(Yabai.State.Layout.stack.caseDescription)
//                            .foregroundColor(Color(.gray))
                        
//                        Text("⌃ ⌥ + 3")
//                            .foregroundColor(Color(.gray))

                        KeyboardShortcuts.Recorder(for: .toggleStacking)
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
                            .foregroundColor(.blue)
                        
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
                        
                        Text("Resize")
                            .bold()
                            .font(.title3)
                        
                        Text("⌃ ⌥ + ARROW")
                            .foregroundColor(Color(.gray))
                    }

                    VStack {
                        Rectangle()
                            .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                            .foregroundColor(.red)
                        
                        Text("Move")
                            .bold()
                            .font(.title3)
                        
                        Text("⌃ ⌥ ⌘ + ARROW")
                            .foregroundColor(Color(.gray))
                        
                    }
                }
                .padding(.horizontal, 30)
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
            VStack {
                LayoutButtonsView(store: store)
                Divider()
//                GapsView(store: store)
//                Divider()
                ShortcutsView(store: store)

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


