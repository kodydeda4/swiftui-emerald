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
            HStack {
                settings
                    .padding()
                    .navigationSubtitle("New Window")

                Rectangle()
                    .foregroundColor(.black)
            }
        }
    }
}


extension NewWindowSettings {
    var settings: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("New Window").bold()
                    Picker("", selection: vs.binding(keyPath: \.windowPlacement, send: k)) {
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
                Divider()
                // Split Ratio
                VStack(alignment: .leading) {
                    Text("Split Ratio").bold()
                    Picker("", selection: vs.binding(keyPath: \.windowBalance, send: k)) {
                        ForEach(Yabai.State.WindowBalance.allCases) {
                            Text($0.uiDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                    
                    Slider(value: vs.binding(keyPath: \.splitRatio, send: k))
                    
                    Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                        .foregroundColor(Color(.gray))

                }
                Spacer()
            }
        }
    }
}


struct NewWindowSettings_Previews: PreviewProvider {
    static var previews: some View {
        NewWindowSettings(store: Yabai.defaultStore)
    }
}
