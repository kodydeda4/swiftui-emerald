//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture

struct SpaceSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            HStack {
                settings
                    .padding()
                    .navigationTitle("Space")

                Rectangle()
                    .foregroundColor(.black)
            }
        }
    }
}

extension SpaceSettingsView {
    var settings: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading, spacing: 20) {
                // Layout
                VStack(alignment: .leading) {
                    Text("Layout").bold().font(.title3)
                    Picker("", selection: vs.binding(keyPath: \.layout, send: k)) {
                        ForEach(Yabai.State.Layout.allCases) {
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
                // Padding
                VStack(alignment: .leading) {
                    Text("Padding").bold().font(.title3)
                    HStack {
                        StepperView(
                            text: "Top",
                            value: vs.binding(keyPath: \.paddingTop, send: k),
                            isEnabled: vs.layout != .float
                        )
                        StepperView(
                            text: "Bottom",
                            value: vs.binding(keyPath: \.paddingBottom, send: k),
                            isEnabled: vs.layout != .float
                        )
                        StepperView(
                            text: "Left",
                            value: vs.binding(keyPath: \.paddingLeft, send: k),
                            isEnabled: vs.layout != .float
                        )
                        StepperView(
                            text: "Right",
                            value: vs.binding(keyPath: \.paddingRight, send: k),
                            isEnabled: vs.layout != .float
                        )
                        StepperView(
                            text: "Gaps",
                            value: vs.binding(keyPath: \.windowGap, send: k),
                            isEnabled: vs.layout != .float
                        )
                    }
                }
                
                Spacer()
            }
        }
    }
}

// MARK:- SwiftUI_Previews
struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Yabai.defaultStore)
    }
}


