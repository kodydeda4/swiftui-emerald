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
                        Button("off") {
                            vs.send(.updateExternalBar(.off))
                        }
                        Button("all") {
                            vs.send(.updateExternalBar(.all))
                        }
                        Button("main") {
                            vs.send(.updateExternalBar(.main))
                        }
                    }
                }
                Section(header: Text("Padding").bold()) {
                    HStack {
                        MyStepperView("Top",    value: vs.binding(keyPath: \.externalBarPaddingTop,    send: k))
                        MyStepperView("Bottom", value: vs.binding(keyPath: \.externalBarPaddingBottom, send: k))
                    }.disabled(vs.externalBar == .off)
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
