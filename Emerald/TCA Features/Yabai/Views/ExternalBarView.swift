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
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading, spacing: 20) {
                
                // External Bar
                VStack(alignment: .leading) {
                    HStack {
                        Toggle("", isOn: vs.binding(keyPath: \.externalBarEnabled, send: Yabai.Action.keyPath))
                            .labelsHidden()
                        
                        Text("External Bar")
                            .bold().font(.title3)
                    }
                    Picker("", selection: vs.binding(keyPath: \.externalBar, send: Yabai.Action.keyPath)) {
                        ForEach(Yabai.State.ExternalBar.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
                    .disabled(!vs.externalBarEnabled)
                    .opacity(!vs.externalBarEnabled ? 0.5 : 1.0)
                    
                    Text(vs.externalBar.caseDescription)
                        .foregroundColor(Color(.gray))
                        .opacity(!vs.externalBarEnabled ? 0.5 : 1.0)
                }
                
                // Padding
                VStack(alignment: .leading) {
                    Divider()
                    Text("Padding")
                        .bold().font(.title3)
                    
                    HStack {
                        StepperTextfield("Top", vs.binding(keyPath: \.externalBarPaddingTop, send: Yabai.Action.keyPath))
                        StepperTextfield("Bottom", vs.binding(keyPath: \.externalBarPaddingBottom, send: Yabai.Action.keyPath))
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
