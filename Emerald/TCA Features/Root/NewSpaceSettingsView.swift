//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture
import KeyboardShortcuts

struct NewSpaceSettingsView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Layout")
                        .font(.largeTitle)
                        .bold()
                    Divider()
                    HStack {
//                        ForEach(Yabai.State.Layout.allCases) {
//                            LayoutShortcutView(layout: $0, action: { $0 })
//                        }
                        ShortcutView(shortcut: KeyboardShortcuts.Name.float, action: { viewStore.send(.skhd(.updateFloat($0))) })
                        ShortcutView(shortcut: KeyboardShortcuts.Name.bsp, action: { viewStore.send(.skhd(.updateBsp($0))) })
                        ShortcutView(shortcut: KeyboardShortcuts.Name.stack, action: { viewStore.send(.skhd(.updateStack($0))) })
                    }
                }
                VStack(alignment: .leading) {
                    Text("Shortcuts")
                        .font(.largeTitle)
                        .bold()
                    Divider()
                    HStack {
                        ShortcutView(shortcut: KeyboardShortcuts.Name.focus, action: { viewStore.send(.skhd(.updateFocus($0))) })
                        ShortcutView(shortcut: KeyboardShortcuts.Name.resize, action: { viewStore.send(.skhd(.updateResize($0))) })
                        ShortcutView(shortcut: KeyboardShortcuts.Name.move, action: { viewStore.send(.skhd(.updateMove($0))) })
                        
//                        ForEach([KeyboardShortcuts.Name.focus, .resize, .move], id: \.self) {
//                            ShortcutView(shortcut: $0, action: { viewStore.send(.skhd(.updateFocus($0))) })
//                        }
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

//struct MyKeyboardShortcutsView: View {
//    let title: String
//    let shortcut: KeyboardShortcuts.Name
//    let action: ((KeyboardShortcuts.Shortcut?) -> Void)?
//
//    init(_ title: String,
//         _ shortcut: KeyboardShortcuts.Name,
//         _ action: ((KeyboardShortcuts.Shortcut?) -> Void)?
//    ) {
//        self.title = title
//        self.shortcut = shortcut
//        self.action = action
//    }
//
//    var body: some View {
//        HStack {
//            HStack {
//                Text(title)
//                Spacer()
//            }
//            .frame(width: 110)
//            KeyboardShortcuts.Recorder(for: shortcut, onChange: action)
//        }
//    }
//}

struct LayoutShortcutView: View {
    var layout: Yabai.State.Layout
    var action: ((KeyboardShortcuts.Shortcut?) -> Void)?
    @State var hovering = false
    
    let angle: Double = -15
    let x: CGFloat = 0
    let y: CGFloat = 90
    let z: CGFloat = -30

    
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
                    .opacity(0.80)
                
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
                            //back
                            Window()
                                .padding([.leading, .top],     hovering ? 32 : 0)
                                //.padding([.trailing, .bottom], hovering ?  0 : 0)
                                .padding(.horizontal, hovering ? 0 : 32)
                                .animation(.spring())
                                .rotation3DEffect(
                                    Angle(degrees: hovering ? angle : 0),
                                    axis: (x: x, y: y, z: z)
                                )

                            //middle
                            Window()
                                .padding([.leading, .top],     hovering ? 16 : 0)
                                .padding(.trailing, hovering ? 16 : 0)
                                .padding(.horizontal, hovering ? 0 : 16)

                                .padding(.bottom, 16)
                                .animation(.spring())
                                .rotation3DEffect(
                                    Angle(degrees: hovering ? angle : 0),
                                    axis: (x: x, y: y, z: z)
                                )

                            //top
                            Window()
                                .padding([.leading, .top],     hovering ?  0 : 0)
                                .padding(.trailing, hovering ? 32 : 0)
                                .padding(.bottom, 32)
                                .animation(.spring())
                                .rotation3DEffect(
                                    Angle(degrees: hovering ? angle : 0),
                                    axis: (x: x, y: y, z: z)
                                )
                        }

                    }
                }
                .aspectRatio(CGSize(width: 16, height: 10), contentMode: .fill)
                .scaleEffect(hovering ? 0.9 : 1)
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
            
            KeyboardShortcuts.Recorder(for: shortcut, onChange: action)
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
    var action: ((KeyboardShortcuts.Shortcut?) -> Void)?
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
                    } else {
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
                    TextField("", text: .constant("⌃ + Arrow"))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .frame(width: 130)
                    
                } else if shortcut == .resize {
                    TextField("", text: .constant("⌃⌥ + Arrow"))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .frame(width: 130)
                } else if shortcut == .move {
                    TextField("", text: .constant("⌃⌥⌘ + Arrow"))
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
//            .border(Color.white.blendMode(.overlay))
            
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
struct NewSpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NewSpaceSettingsView(store: Root.defaultStore)
    }
}

