//
//  MouseSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture

struct MouseSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            
            TabView {
                MouseModfiersView(store: store)
                    .tabItem { Text("Mouse Buttons") }

                DropActionView(store: store)
                    .tabItem { Text("Drop Action") }

                FocusSettingsView(store: store)
                    .tabItem { Text("Focus Behavior") }
            }
            .padding()
            .frame(maxWidth: 900)
        }
    }
}

struct MouseModfiersView: View {
    let store: Store<Yabai.State, Yabai.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading, spacing: 20) {
                
                // Left Click + Modifier
                VStack(alignment: .leading) {
                    Text("Left Click + Modifier")
                        .bold().font(.title3)
                    
                    Picker("", selection: viewStore.binding(keyPath: \.mouseAction1, send: Yabai.Action.keyPath)) {
                        ForEach(Yabai.State.MouseAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden().pickerStyle(SegmentedPickerStyle()).frame(width: 100)
                    
                    Text(viewStore.mouseAction1.caseDescription)
                        .foregroundColor(Color(.gray))
                }
                
                // Right Click + Modifier
                VStack(alignment: .leading) {
                    Text("Right Click + Modifier")
                        .bold().font(.title3)
                    
                    Picker("", selection: viewStore.binding(keyPath: \.mouseAction2, send: Yabai.Action.keyPath)) {
                        ForEach(Yabai.State.MouseAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden().pickerStyle(SegmentedPickerStyle()).frame(width: 100)
                    
                    Text(viewStore.mouseAction2.caseDescription)
                        .foregroundColor(Color(.gray))
                }

                // Modifier Key
                VStack(alignment: .leading) {
                    Text("Modifier Key")
                        .bold().font(.title3)
                    
                    Picker("", selection: viewStore.binding(keyPath: \.mouseModifier, send: Yabai.Action.keyPath)) {
                        ForEach(Yabai.State.MouseModifier.allCases) {
                            Text($0.labelDescription.lowercased())
                        }
                    }
                    .labelsHidden().pickerStyle(SegmentedPickerStyle()).frame(width: 350)
                    
                            Text("Press & hold for mouse actions")
                                .foregroundColor(Color(.gray))
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct DropActionView: View {
    let store: Store<Yabai.State, Yabai.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            
            VStack(alignment: .leading) {
                Text("Drop Action")
                    .bold().font(.title3)
                
                Picker("", selection: viewStore.binding(keyPath: \.mouseDropAction, send: Yabai.Action.keyPath)) {
                    ForEach(Yabai.State.MouseDropAction.allCases) {
                        Text($0.rawValue)
                    }
                }
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 100)
                
                Text(viewStore.mouseDropAction.caseDescription)
                    .foregroundColor(Color(.gray))
                
                Spacer()
            }
            .padding()
        }
    }
}

struct FocusSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading) {
                
                // AutoFocus
                VStack(alignment: .leading) {
                    Text("Mouse Focus")
                        .bold().font(.title3)

                    Picker("", selection: vs.binding(keyPath: \.focusFollowsMouse, send: Yabai.Action.keyPath)) {
                        ForEach(Yabai.State.FocusFollowsMouse.allCases) {
                            Text($0.labelDescription.lowercased())
                        }
                    }
                    .labelsHidden().pickerStyle(SegmentedPickerStyle()).frame(width: 250)

                    Text(vs.focusFollowsMouse.caseDescription)
                        .foregroundColor(Color(.gray))
                }
                
                // Follow Focus
                VStack(alignment: .leading) {
                    Divider()
                    HStack {
                        Group {
                            Toggle("Enabled", isOn: vs.binding(keyPath: \.mouseFollowsFocus, send: Yabai.Action.keyPath))
                                .labelsHidden()
                            
                            Text("Follow Focus")
                                .bold().font(.title3)
                        }
                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    
                    Text("Mouse will automatically reposition itself to center of focused window")
                        .foregroundColor(Color(.gray))
                }
                Spacer()
            }
            .padding()
        }
    }
}

// MARK:- SwiftUI_Previews
struct MouseSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MouseSettingsView(store: Yabai.defaultStore)
    }
}
