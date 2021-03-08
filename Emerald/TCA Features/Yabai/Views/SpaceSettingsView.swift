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
            SectionView("Space") {
                Section(header: Text("Layout").bold()) {
                    Picker("", selection: vs.binding(keyPath: \.layout, send: k)) {
                        ForEach(Yabai.State.Layout.allCases) {
                            Text($0.uiDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                }
                Divider()
                Section(header: Text("Padding").bold()) {
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
