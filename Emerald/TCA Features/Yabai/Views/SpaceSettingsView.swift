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
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                VStack(spacing: 30) {
                    HStack {
                        Text("Layout")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    Divider()
                    HStack {
                        ForEach(Yabai.State.Layout.allCases) { i in
                            Button(action: { viewStore.send(.updateLayout(i)) }) {
                                LayoutShortcutView(layout: i)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                VStack(spacing: 30) {
                    HStack {
                        Text("Shortcuts")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    Divider()
                    HStack {
                        ForEach([KeyboardShortcuts.Name.focus, .resize, .move, .gaps, .padding, .balance, .split], id: \.self) { i in
                            VStack {
                                Button(action: {}) {
                                    //LayoutShortcutView(shortcut: i)
                                    Text("")
                                }
                                .buttonStyle(PlainButtonStyle())
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                                
                                Text(i.rawValue)
                                    .bold()
                                    .font(.title3)
                                
                                if i == .focus {
                                    TextField("", text: .constant("⌃ Arrow"))
                                        .multilineTextAlignment(.center)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 130)
                                    
                                } else if i == .resize {
                                    TextField("", text: .constant("⌃⌥ Arrow"))
                                        .multilineTextAlignment(.center)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 130)
                                    
                                } else if i == .move {
                                    TextField("", text: .constant("⌃⌥⌘ Arrow"))
                                        .multilineTextAlignment(.center)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 130)
                                }
                                else {
                                    KeyboardShortcuts.Recorder(for: i)
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: 1200)
            .padding(.horizontal, 30)
            .padding(.vertical)
            .navigationTitle("")
            
            //.navigationTitle("Layout")
        }
    }
}




struct LayoutShortcutView: View {
    var layout: Yabai.State.Layout
    
    var bgColor: Color {
        switch layout {
        case .float : return Color(.systemBlue)
        case .bsp   : return Color(.systemGreen)
        case .stack : return Color(.systemOrange)
        }
    }
    
    //KeyboardShortcuts.Recorder(for: i)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(layout.labelDescription)
                .bold()
                .font(.title)
                .shadow(radius: 2, y: 2)
            
            Text(layout.caseDescription)
                .lineLimit(1)
                .padding(.bottom)
                .shadow(radius: 2, y: 2)
            
            GeometryReader { geo in
                if layout == .float {
                    HStack {
                        window
                            .padding(.vertical)
                        
                        VStack {
                            window
                                .padding(.leading)
                            window
                                .padding()
                                .padding(.bottom)
                        }
                    }
                } else if layout == .bsp {
                    HStack {
                        window
                        VStack {
                            window
                            window
                        }
                    }
                    
                } else if layout == .stack {
                    ZStack {
                        VStack {
                            window.frame(width: geo.size.width * 0.8, height: geo.size.height * 1.0)
                            Spacer()
                        }
                        VStack {
                            window.frame(width: geo.size.width * 0.9, height: geo.size.height * 0.9)
                            Spacer()
                        }
                        VStack {
                            window.frame(width: geo.size.width * 1.0, height: geo.size.height * 0.8)
                            Spacer()
                        }
                    }
                }
            }
            .shadow(radius: 10, y: 6)
            .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
        }
        .padding()
        .padding()
        .background(Color.black.opacity(0.2))
        .background(bgColor)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        //.shadow(radius: 3)
    }
    
    var window: some View {
        RoundedRectangle(cornerRadius: 6)
            .foregroundColor(Color(.windowBackgroundColor))
            .shadow(radius: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray, lineWidth: 0.75)
            )
    }
}

// MARK:- SwiftUI_Previews
struct LayoutShortcutView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutShortcutView(layout: .float)
        LayoutShortcutView(layout: .bsp)
        LayoutShortcutView(layout: .stack)
    }
}



// MARK:- SwiftUI_Previews
struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Yabai.defaultStore)
    }
}


