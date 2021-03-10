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
            VStack(alignment: .leading, spacing: 20) {
                
                // Placement
                VStack(alignment: .leading) {
                    Text("Placement")
                        .bold().font(.title3)
                    
                    Picker("", selection: vs.binding(\.windowPlacement, k)) {
                        ForEach(Yabai.State.WindowPlacement.allCases) {
                            Text($0.uiDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                    
                    Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                        .foregroundColor(Color(.gray))
                    
                }

                // Split Ratio
                VStack(alignment: .leading) {
                    Divider()
                    
                    Text("Split Ratio")
                        .bold().font(.title3)
                    
                    Picker("", selection: vs.binding(\.windowBalance, k)) {
                        ForEach(Yabai.State.WindowBalance.allCases) {
                            Text($0.uiDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                    
                    Slider(value: vs.binding(\.splitRatio, k))
                        .disabled(vs.windowBalance != .custom)
                        .opacity(vs.windowBalance != .custom ? 0.5 : 1.0)

                    Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                        .foregroundColor(Color(.gray))
                    
                }
                Spacer()
            }
            .padding()
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
