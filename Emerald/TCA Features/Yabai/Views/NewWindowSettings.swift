//
//  NewWindowSettings.swift
//  Emerald
//
//  Created by Kody Deda on 3/9/21.
//

import SwiftUI
import ComposableArchitecture

struct NewWindowSettings: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            ScrollView {
                SectionView("Placement") {
                    Picker("", selection: vs.binding(\.windowPlacement, k)) {
                        ForEach(Yabai.State.WindowPlacement.allCases) {
                            Text($0.labelDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                    
                    Text(vs.windowPlacement.caseDescription)
                        .foregroundColor(Color(.gray))
                }
                SectionView("Split Ratio") {
                    Picker("", selection: vs.binding(\.windowBalance, k)) {
                        ForEach(Yabai.State.WindowBalance.allCases) {
                            Text($0.labelDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                    
                    Slider(value: vs.binding(\.splitRatio, k))
                        .disabled(vs.windowBalance != .custom)
                        .opacity(vs.windowBalance != .custom ? 0.5 : 1.0)
                    
                    Text(vs.windowBalance.caseDescription)
                        .foregroundColor(Color(.gray))
                }
            }
            .navigationTitle("Space")
        }
    }
}

// MARK:- SwiftUI_Previews
struct NewWindowSettings_Previews: PreviewProvider {
    static var previews: some View {
        NewWindowSettings(store: Yabai.defaultStore)
    }
}
