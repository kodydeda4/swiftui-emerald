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
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Modifier Key").bold().font(.title3)
                    Picker("", selection: vs.binding(keyPath: \.mouseModifier, send: k)) {
                        ForEach(Yabai.State.MouseModifier.allCases) {
                            //Image(systemName: "rectangle.grid.2x2.fill")
                            Text($0.uiDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 350)
                    
                    Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                        .foregroundColor(Color(.gray))
                    
                }
                Section {
                    Divider()
                    VStack(alignment: .leading) {
                        Text("Left Click + Modifier").bold().font(.title3)
                        Picker("", selection: vs.binding(keyPath: \.mouseAction1, send: k)) {
                            ForEach(Yabai.State.MouseAction.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }
                    Divider()
                    VStack(alignment: .leading) {
                        Text("Right Click + Modifier").bold().font(.title3)
                        Picker("", selection: vs.binding(keyPath: \.mouseAction2, send: k)) {
                            ForEach(Yabai.State.MouseAction.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }
                    Divider()
                    VStack(alignment: .leading) {
                        Text("Drop Action").bold().font(.title3)
                        Picker("", selection: vs.binding(keyPath: \.mouseDropAction, send: k)) {
                            ForEach(Yabai.State.MouseDropAction.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                        
                        Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                            .foregroundColor(Color(.gray))
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Space")
        }
    }
}

// MARK:- SwiftUI_Previews
struct MouseSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MouseSettingsView(store: Yabai.defaultStore)
    }
}
