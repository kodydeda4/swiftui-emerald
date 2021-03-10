//
//  ExternalBarSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture

struct ExternalBarSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    HStack {
                        Toggle("", isOn: vs.binding(keyPath: \.externalBarEnabled, send: k)).labelsHidden()
                        Text("External Bar").bold().font(.title3)
                    }
                    Picker("", selection: vs.binding(keyPath: \.externalBar, send: k)) {
                        ForEach(Yabai.State.ExternalBar.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
                    .disabled(!vs.externalBarEnabled)
                    
                    Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                        .foregroundColor(Color(.gray))
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("Padding").bold().font(.title3)
                    HStack {
                        StepperView("Top", vs.binding(keyPath: \.externalBarPaddingTop, send: k))
                        StepperView("Bottom", vs.binding(keyPath: \.externalBarPaddingBottom, send: k))
                    }
                }
                .disabled(!vs.externalBarEnabled)
                .opacity(!vs.externalBarEnabled ? 0.5 : 1.0)

                Spacer()
            }
            .padding()
            .navigationTitle("Space")
        }
    }
}

// MARK:- SwiftUI_Previews
struct ExternalBarSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ExternalBarSettingsView(store: Yabai.defaultStore)
    }
}
