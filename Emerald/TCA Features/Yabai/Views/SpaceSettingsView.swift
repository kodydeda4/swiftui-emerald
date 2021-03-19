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
                        ForEach(Yabai.State.Layout.allCases) { str in
                            VStack {
                                VStack(alignment: .leading) {
                                    Text(str.labelDescription)
                                        .bold()
                                        .font(.title3)
                                
                                    Text(str.caseDescription)
                                        .lineLimit(1)
                                        .foregroundColor(Color(.gray))
                                    
                                    Button(action: { viewStore.send(.updateLayout(str)) }) {
                                        RoundedRectangle(cornerRadius: 6)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                                    .foregroundColor(viewStore.layout == str ? .accentColor : .gray)
                                }
                                KeyboardShortcuts.Recorder(for: .toggleFloating)
                            }
                        }
                    }
                }
                Divider()
                VStack(spacing: 30) {
                    HStack {
                        Text("Shortcuts")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        ForEach(["Focus", "Resize", "Move", "Gaps", "Balance", "Split"], id: \.self) { str in
                            VStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(.red)
                                    .aspectRatio(
                                        CGSize(width: 16, height: 9),
                                        contentMode: .fit)
                                
                                Text(str)
                                    .bold()
                                    .font(.title3)
                                
                                KeyboardShortcuts.Recorder(for: .moveNorth)
                                //Text("⌃ + ARROW")
                                //    .foregroundColor(Color(.gray))
                            }
                        }
                    }
                }
//                Divider()
//                VStack(spacing: 30) {
//                    HStack {
//                        Text("Gaps")
//                            .font(.title)
//                            .bold()
//                        Spacer()
//                    }
//                    HStack {
//                        VStack {
//                            Rectangle()
//                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
//                                .foregroundColor(.blue)
//
//                            Text("Inner")
//                                .bold()
//                                .font(.title3)
//
//                            Text("Description")
//                                .foregroundColor(Color(.gray))
//
//
//                            TextField("", value: viewStore.binding(keyPath: \.windowGap, send: Yabai.Action.keyPath), formatter: NumberFormatter())
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .frame(width: 130)
//                                .overlay(
//                                    HStack {
//                                        Spacer()
//                                        Stepper("", value: viewStore.binding(keyPath: \.windowGap, send: Yabai.Action.keyPath), in: 0...30)
//                                    }
//                                )
//                            KeyboardShortcuts.Recorder(for: .toggleGaps)
//                        }
//                        VStack {
//                            Rectangle()
//                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
//                                .foregroundColor(.blue)
//
//                            Text("Outer")
//                                .bold()
//                                .font(.title3)
//
//                            Text("Description")
//                                .foregroundColor(Color(.gray))
//
//                            TextField("", value: viewStore.binding(keyPath: \.padding, send: Yabai.Action.keyPath), formatter: NumberFormatter())
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .overlay(
//                                    HStack {
//                                        Spacer()
//                                        Stepper("", value: viewStore.binding(keyPath: \.padding, send: Yabai.Action.keyPath), in: 0...30)
//                                    }
//                                )
//                                .frame(width: 130)
//
//                            KeyboardShortcuts.Recorder(for: .togglePadding)
//                        }
//                    }
//                }
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


