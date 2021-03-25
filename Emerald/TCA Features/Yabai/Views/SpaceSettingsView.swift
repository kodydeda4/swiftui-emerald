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
                        ForEach([KeyboardShortcuts.Name.float, .bsp, .stack], id: \.self) { i in
                            VStack {
                                VStack(alignment: .leading) {
                                    Text(i.rawValue)
                                        .bold()
                                        .font(.title2)
                                        .shadow(radius: 2)
                                    
                                    Text("Description about \(i.rawValue)")
                                        .lineLimit(1)
                                        .foregroundColor(Color(.gray))
                                        .shadow(radius: 2)

                                    Button(action: { viewStore.send(.updateLayout(i)) }) {
                                        LayoutShortcutView(shortcut: i)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                                }
                                KeyboardShortcuts.Recorder(for: i)
                            }
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
                                    LayoutShortcutView(shortcut: i)
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
    var shortcut: KeyboardShortcuts.Name
    
    var bgColor: Color {
        switch shortcut {
        case .float:
            return Color(.systemBlue)
        case .bsp:
            return Color(.systemGreen)
        case .stack:
            return Color(.systemOrange)
            
        default:
            return .white//Color(.controlBackgroundColor)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            if shortcut == .float {
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
            } else if shortcut == .bsp {
                HStack {
                    window
                    VStack {
                        window
                        window
                    }
                }
                
            } else if shortcut == .stack {
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
        .shadow(radius: 5, y: 8)
        .padding()
        .padding()
        .background(Color.black.opacity(0.1))
        .background(bgColor)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .shadow(radius: 4)
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
        LayoutShortcutView(shortcut: .float)
        LayoutShortcutView(shortcut: .bsp)
        LayoutShortcutView(shortcut: .stack)
    }
}



// MARK:- SwiftUI_Previews
struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Yabai.defaultStore)
    }
}


