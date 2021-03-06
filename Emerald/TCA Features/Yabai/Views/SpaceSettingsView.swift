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
                    HStack {
                        Button("Floating (Normal)") {
                            vs.send(.updateLayout(.float))
                        }
                        Button("Tiling") {
                            vs.send(.updateLayout(.bsp))
                        }
                        Button("Stacking") {
                            vs.send(.updateLayout(.stack))
                        }
                    }
                }
                Divider()
                Section(header: Text("Padding").bold()) {
                    HStack {
                        MyStepperView("Top",    value: vs.binding(keyPath: \.paddingTop,    send: k), isEnabled: true)
                        MyStepperView("Bottom", value: vs.binding(keyPath: \.paddingBottom, send: k), isEnabled: true)
                        MyStepperView("Left",   value: vs.binding(keyPath: \.paddingLeft,   send: k), isEnabled: true)
                        MyStepperView("Right",  value: vs.binding(keyPath: \.paddingRight,  send: k), isEnabled: true)
                        MyStepperView("Gaps",   value: vs.binding(keyPath: \.windowGap,     send: k), isEnabled: true)
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
