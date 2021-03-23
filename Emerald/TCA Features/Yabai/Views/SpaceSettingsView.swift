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
                                        .font(.title3)
                                    
                                    Text("Fee fo fi fum fo fi fum fo fi fum fo fi fum fo fi fum fo fi fum")
                                        .lineLimit(1)
                                        .foregroundColor(Color(.gray))
                                
                                    Button(action: {}) {
                                        RoundedRectangle(cornerRadius: 6)
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
                                    RoundedRectangle(cornerRadius: 6)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                                
                                Text(i.rawValue)
                                    .bold()
                                    .font(.title3)
                            
                                KeyboardShortcuts.Recorder(for: i)
                            }
                        }
                    }
                }
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


