//
//  FocusSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/9/21.
//

import SwiftUI
import ComposableArchitecture

struct FocusSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    HStack {
                        Toggle("", isOn: vs.binding(keyPath: \.focusFollowsMouseEnabled, send: k)).labelsHidden()
                        Text("Auto Focus").bold().font(.title3)
                    }
                    
                    Picker("", selection: vs.binding(keyPath: \.focusFollowsMouse, send: k)) {
                        ForEach(Yabai.State.FocusFollowsMouse.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 150)
                    .disabled(!vs.focusFollowsMouseEnabled)
                    
                    Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                        .foregroundColor(Color(.gray))
                    
                }
                Divider()
                VStack(alignment: .leading) {
                    HStack {
                        Toggle("Enabled", isOn: vs.binding(keyPath: \.mouseFollowsFocus, send: k)).labelsHidden()
                        Text("Follow Focus").bold().font(.title3)
                        
                    }
                    
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
struct FocusSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        FocusSettingsView(store: Yabai.defaultStore)
    }
}

