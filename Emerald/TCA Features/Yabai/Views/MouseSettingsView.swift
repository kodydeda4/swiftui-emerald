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
            ScrollView {
                SectionView("Modifier Key") {
                    Picker("", selection: vs.binding(\.mouseModifier, k)) {
                        ForEach(Yabai.State.MouseModifier.allCases) {
                            Text($0.labelDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 350)
                    
                    Text("Press & hold for mouse actions")
                        .foregroundColor(Color(.gray))
                }
                
                SectionView("Left Click + Modifier") {
                    Picker("", selection: vs.binding(\.mouseAction1, k)) {
                        ForEach(Yabai.State.MouseAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
                    
                    Text(vs.mouseAction1.caseDescription)
                        .foregroundColor(Color(.gray))
                }
                
                SectionView("Right Click + Modifier") {
                    Picker("", selection: vs.binding(\.mouseAction2, k)) {
                        ForEach(Yabai.State.MouseAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
                    
                    Text(vs.mouseAction2.caseDescription)
                        .foregroundColor(Color(.gray))
                }
            
                SectionView("Drop Action") {
                    Picker("", selection: vs.binding(\.mouseDropAction, k)) {
                        ForEach(Yabai.State.MouseDropAction.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
                    
                    Text(vs.mouseDropAction.caseDescription)
                        .foregroundColor(Color(.gray))
                }
            }
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
