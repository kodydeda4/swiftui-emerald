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
                VStack(alignment: .leading) {
                    Text("Layout")
                        .font(.largeTitle)
                        .bold()
                    Divider()
                    HStack {
                        ForEach(Yabai.State.Layout.allCases) {
                            LayoutShortcutView(layout: $0)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text("Shortcuts")
                        .font(.largeTitle)
                        .bold()
                    Divider()
                    HStack {
                        ForEach([KeyboardShortcuts.Name.focus, .resize, .move], id: \.self) {
                            ShortcutView(shortcut: $0)
                        }
                    }
                    HStack {
                        ForEach([KeyboardShortcuts.Name.split, .balance, .padding, .gaps], id: \.self) {
                            ShortcutView(shortcut: $0)
                        }
                    }
                }
            }
            .frame(maxWidth: 1200)
            .padding()
            .navigationTitle("")
        }
    }
}


struct LayoutShortcutView: View {
    var layout: Yabai.State.Layout
    @State var hovering = false
    
    var bgColor: LinearGradient {
        var g: Gradient {
            switch layout {
            case .float : return Gradient(colors: [Color(hexString: "#B721FF"), Color(hexString: "#21D4FD")])
            case .bsp   : return Gradient(colors: [Color(hexString: "#20bf55"), Color(hexString: "#01baef")])
            case .stack : return Gradient(colors: [Color(hexString: "#ff5f6d"), Color(hexString: "#ffc371")])
            }
        }
        return LinearGradient(gradient: g, startPoint: .top, endPoint: .bottomTrailing)
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
                Text(layout.labelDescription)
                    .bold()
                    .font(.title)
                    .shadow(radius: 1, y: 1)
                    .foregroundColor(.white)
                    .opacity(0.85)
                
                Text(layout.caseDescription)
                    .lineLimit(1)
                    .padding(.top, 1)
                    .padding(.bottom)
                    .shadow(radius: 1, y: 1)
                    .foregroundColor(.white)
                    .opacity(0.85)
                
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
                .aspectRatio(CGSize(width: 16, height: 10), contentMode: .fill)
                .scaleEffect(hovering ? 1.0 : 0.99)
                .animation(.spring(), value: hovering)
            }
            .padding()
            .padding()
            .background(Color.black.opacity(hovering ? 0 : 0.10))
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
        .shadow(radius: 6, y: 5)
        .padding()
    }
}

struct ShortcutView: View {
    var shortcut: KeyboardShortcuts.Name
    @State var hovering = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(shortcut.rawValue)
                    .bold()
                    .font(.title)
                    .shadow(radius: 1, y: 1)
                    .foregroundColor(.white)
                    .opacity(0.85)

                GeometryReader { geo in
                    if shortcut == .focus {
                        Window()
                    }
                }
                .aspectRatio(CGSize(width: 16, height: 10), contentMode: .fill)
                .scaleEffect(hovering ? 1.0 : 0.99)
                .animation(.spring(), value: hovering)
            }
            .padding()
            .padding()
            .background(Color.black.opacity(hovering ? 0 : 0.10))
            //.background(bgColor)
            .animation(.spring(), value: hovering)
            .onHover { _ in
                hovering.toggle()
            }
            
            VStack {
                if shortcut == .focus {
                    TextField("", text: .constant("⌃"))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .frame(width: 130)
                    
                } else if shortcut == .resize {
                    TextField("", text: .constant("⌃⌥"))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .frame(width: 130)
                } else if shortcut == .move {
                    TextField("", text: .constant("⌃⌥⌘"))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .frame(width: 130)
                } else {
                    KeyboardShortcuts.Recorder(for: shortcut)
                }
            }
            .padding()
        }
        .background(Color(.windowBackgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .shadow(radius: 6, y: 5)
        .padding()
    }
}

struct Window: View {
    var color: Color = Color(.windowBackgroundColor)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .foregroundColor(Color(.windowBackgroundColor))
            .shadow(radius: 10, y: 6)
    }
}

// MARK:- SwiftUI_Previews
struct Window_Previews: PreviewProvider {
    static var previews: some View {
        Window()
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


