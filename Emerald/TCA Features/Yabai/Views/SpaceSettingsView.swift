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
    let keyPath = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            SectionView("Space") {
                Section(header: Text("Layout").bold()) {
                    HStack {
                        Button("Floating (Normal)") {
                            viewStore.send(.updateLayout(.float))
                        }
                        Button("Tiling") {
                            viewStore.send(.updateLayout(.bsp))
                        }
                        Button("Stacking") {
                            viewStore.send(.updateLayout(.stack))
                        }
                    }
                }
                Divider()
                Section(header: Text("Padding").bold()) {
                    HStack {
                        MyStepperView("Top", value: viewStore.binding(keyPath: \.paddingTop, send: keyPath))
                        MyStepperView("Bottom", value: viewStore.binding(keyPath: \.paddingBottom, send: keyPath))
                        MyStepperView("Left", value: viewStore.binding(keyPath: \.paddingLeft, send: keyPath))
                        MyStepperView("Right", value: viewStore.binding(keyPath: \.paddingRight, send: keyPath))
                        MyStepperView("Gaps", value: viewStore.binding(keyPath: \.windowGap, send: keyPath))
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
