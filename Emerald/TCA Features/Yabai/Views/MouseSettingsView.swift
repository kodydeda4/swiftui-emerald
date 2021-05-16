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
        }
    }
}

struct MouseModfiersView: View {
    let store: Store<Yabai.State, Yabai.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
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
                
                Divider()
                
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
                
                Divider()
                
                Text("Modifier Key")
                    .bold().font(.title3)
                
                Picker("", selection: viewStore.binding(keyPath: \.mouseModifier, send: Yabai.Action.keyPath)) {
                    ForEach(Yabai.State.MouseModifier.allCases) {
                        Text($0.labelDescription.lowercased())
                    }
                }
                .labelsHidden().pickerStyle(SegmentedPickerStyle()).frame(width: 350)
                
//                Text("Press & hold for mouse actions")
//                    .foregroundColor(Color(.gray))
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
