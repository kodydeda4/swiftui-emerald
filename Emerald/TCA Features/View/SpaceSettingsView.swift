//
//  SpaceSettingsView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

struct SpaceSettingsView: View {
    let store: Store<SpaceSettings.State, SpaceSettings.Action>
    
    var keyPath = SpaceSettings.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Section(header: Text("Layout & Padding")) {
                    Picker("Layout", selection: viewStore.binding(keyPath: \.layout, send: keyPath)) {
                        ForEach(SpaceSettings.State.Layout.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    HStack {
                        Text("Top Padding")
                        TextField("", value: viewStore.binding(keyPath: \.paddingTop, send: keyPath), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Bottom Padding")
                        TextField("", value: viewStore.binding(keyPath: \.paddingBottom, send: keyPath), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Left Padding")
                        TextField("", value: viewStore.binding(keyPath: \.paddingLeft, send: keyPath), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Right Padding")
                        TextField("", value: viewStore.binding(keyPath: \.paddingRight, send: keyPath), formatter: NumberFormatter())
                    }
                }
            }
        }
        .navigationTitle("Space")
    }
}

struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: SpaceSettings.defaultStore)
    }
}
