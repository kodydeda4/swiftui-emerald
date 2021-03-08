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
            SectionView("External Bar") {
                Section(header: Text("External Bar").bold()) {
                    
                    HStack {
                        Toggle("Enabled", isOn: vs.binding(keyPath: \.externalBarEnabled, send: k)).labelsHidden()
                        
                        Picker("", selection: vs.binding(keyPath: \.externalBar, send: k)) {
                            ForEach(Yabai.State.ExternalBar.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                        .disabled(!vs.externalBarEnabled)
                    }
//                    HStack {
//                        Button("off") {
//                            vs.send(.updateExternalBar(.off))
//                        }
//                        Button("all") {
//                            vs.send(.updateExternalBar(.all))
//                        }
//                        Button("main") {
//                            vs.send(.updateExternalBar(.main))
//                        }
//                    }
                }
                Divider()
                Section(header: Text("Padding").bold()) {
                    HStack {
                        StepperView(
                            text: "Top",
                            value: vs.binding(keyPath: \.externalBarPaddingTop, send: k),
                            isEnabled: vs.externalBarEnabled
                        )
                        StepperView(
                            text: "Bottom",
                            value: vs.binding(keyPath: \.externalBarPaddingBottom, send: k),
                            isEnabled: vs.externalBarEnabled
                        )
                    }
                }
            }
        }
    }
}

// MARK:- SwiftUI_Previews
struct ExternalBarSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ExternalBarSettingsView(store: Yabai.defaultStore)
    }
}
