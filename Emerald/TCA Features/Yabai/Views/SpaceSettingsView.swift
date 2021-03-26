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
//                            Button(action: { viewStore.send(.updateLayout(i)) }) {
//                                LayoutShortcutView(layout: i, selected: viewStore.layout == i)
//                            }
//                            .buttonStyle(PlainButtonStyle())
//                            .padding(.vertical)
//                            .padding(.horizontal, 6)
                            LayoutShortcutView(layout: i, selected: viewStore.layout == i)
                                .padding()
                                                        //.padding(.vertical)
                                                        //.padding(.horizontal, 6)

                        }
                    }
                }
                .padding(.bottom)
                
                VStack {
                    HStack {
                        Text("Shortcuts")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    Divider()
                        .padding(.bottom)
                    HStack {
                        ForEach([KeyboardShortcuts.Name.focus, .resize, .move, .gaps, .padding, .balance, .split], id: \.self) { i in
                            VStack {
                                Button(action: {}) {
                                    RoundedRectangle(cornerRadius: 6)
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
            .padding(.horizontal, 30)
            .padding(.vertical)
            .frame(maxWidth: 1200)
            //.padding(.horizontal, 30)
            //.padding(.vertical)
            .navigationTitle("")
            
            //.navigationTitle("Layout")
        }
    }
}

struct LayoutShortcutView: View {
    var layout: Yabai.State.Layout
    var selected: Bool
    @State var hovering = false
    
    var bgColor: LinearGradient {
        switch layout {
        case .float : return LinearGradient(gradient: Gradient(colors: [Color(hexString: "#B721FF"), Color(hexString: "#21D4FD")]), startPoint: .top, endPoint: .bottomTrailing)
        case .bsp   : return LinearGradient(gradient: Gradient(colors: [Color(hexString: "#20bf55"), Color(hexString: "#01baef")]), startPoint: .top, endPoint: .bottomTrailing)
        case .stack : return LinearGradient(gradient: Gradient(colors: [Color(hexString: "#ff5f6d"), Color(hexString: "#ffc371")]), startPoint: .top, endPoint: .bottomTrailing)
        }
    }
    
    var shortcut: KeyboardShortcuts.Name {
        switch layout {
        case .float : return .float
        case .bsp   : return .bsp
        case .stack : return .stack
        }
    }
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(layout.labelDescription)
                        .bold()
                        .font(.title)
                        .shadow(radius: 2, y: 2)
                        .foregroundColor(.white)
                    
                    Text(layout.caseDescription)
                        .lineLimit(1)
                        .padding(.top, 1)
                        .padding(.bottom)
                        .shadow(radius: 2, y: 2)
                        .foregroundColor(.white)
                }
                //.scaleEffect(hovering ? 1.0 : 0.95)
                .animation(.spring(), value: hovering)
                
                
                GeometryReader { geo in
                    if layout == .float {
                        Window()
                    } else if layout == .bsp {
                        HStack {
                            Window()
                            VStack {
                                Window()
                                Window()
                            }
                        }
                    } else if layout == .stack {
                        ZStack {
                            VStack {
                                Window().frame(width: geo.size.width * 0.8, height: geo.size.height * 1.0)
                                Spacer()
                            }
                            VStack {
                                Window().frame(width: geo.size.width * 0.9, height: geo.size.height * 0.9)
                                Spacer()
                            }
                            VStack {
                                Window().frame(width: geo.size.width * 1.0, height: geo.size.height * 0.8)
                                Spacer()
                            }
                        }
                    }
                }
                .shadow(radius: 10, y: 10)
                .aspectRatio(CGSize(width: 16, height: 10), contentMode: .fill)
                .scaleEffect(hovering ? 1.0 : 0.98)
                .animation(.spring(), value: hovering)
            }
            .padding()
            .padding()
            //.background(Color.black.opacity(hovering || selected ? 0 : 1))
            .background(bgColor)
            .animation(.spring(), value: hovering)
            .onHover { _ in
                hovering.toggle()
            }
            
            KeyboardShortcuts.Recorder(for: shortcut)
                .padding()
        }
        .background(Color(.windowBackgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .shadow(radius: 7, y: 2)
    }
}

struct Window: View {
    var color: Color = Color(.windowBackgroundColor)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .foregroundColor(Color(.windowBackgroundColor))
            .shadow(radius: 2)
    }
}

// MARK:- SwiftUI_Previews
struct LayoutShortcutView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutShortcutView(layout: .float, selected: true)
        LayoutShortcutView(layout: .bsp, selected: true)
        LayoutShortcutView(layout: .stack, selected: true)
    }
}



// MARK:- SwiftUI_Previews
struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Yabai.defaultStore)
    }
}


