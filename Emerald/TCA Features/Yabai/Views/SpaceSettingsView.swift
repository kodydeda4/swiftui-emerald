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
        WithViewStore(store) { viewStore in
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
                            Button(action: { viewStore.send(.updateLayout(str)) }) {
                                Rectangle()
                            }
                            .buttonStyle(PlainButtonStyle())
                            .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
                            .foregroundColor(viewStore.layout == str ? .accentColor : .gray)
                            
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
    
    var body: some View {
        WithViewStore(store) { viewStore in
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
                        
                        
                        TextField("", value: viewStore.binding(keyPath: \.windowGap, send: Yabai.Action.keyPath), formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 130)
                            .overlay(
                                HStack {
                                    Spacer()
                                    Stepper("", value: viewStore.binding(keyPath: \.windowGap, send: Yabai.Action.keyPath), in: 0...30)
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

                        TextField("", value: viewStore.binding(keyPath: \.padding, send: Yabai.Action.keyPath), formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(
                                HStack {
                                    Spacer()
                                    Stepper("", value: viewStore.binding(keyPath: \.padding, send: Yabai.Action.keyPath), in: 0...30)
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
    
    enum Shortcuts: String, Identifiable, CaseIterable {
        var id: Shortcuts { self }
        case arrows = "Arrows"
        case vim = "Vim"
    }
    
    @State var shortcut: Shortcuts = .arrows
    
    
    var body: some View {
        WithViewStore(store) { viewStore in
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
                HStack {
                    ForEach(["top", "bottom", "left", "right"], id: \.self) { str in
                        VStack {
                            Image(systemName: "square.\(str)half.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.red)

                            Text(str)
                                .bold()
                                .font(.title3)
                        }
                        .padding(.horizontal)
                    }
                }
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
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                LayoutButtonsView(store: store)
                Divider()
                GapsView(store: store)
                Divider()
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


