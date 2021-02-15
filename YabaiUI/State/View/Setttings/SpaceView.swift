//
//  SpaceSettingsView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

struct SpaceView: View {
    let store: Store<Space.State, Space.Action>
    @State var errorMessage: String = ""
    
    var form = Space.Action.form
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Section(header: Text("Layout & Padding")) {
                    //Text(errorMessage)
                    Picker("Layout", selection: viewStore.binding(keyPath: \.layout, send: form)) {
                        ForEach(Space.State.Layout.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    HStack {
                        Text("Top Padding")
                        TextField("", value: viewStore.binding(keyPath: \.paddingTop, send: form), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Bottom Padding")
                        TextField("", value: viewStore.binding(keyPath: \.paddingBottom, send: form), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Left Padding")
                        TextField("", value: viewStore.binding(keyPath: \.paddingLeft, send: form), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Right Padding")
                        TextField("", value: viewStore.binding(keyPath: \.paddingRight, send: form), formatter: NumberFormatter())
                    }
                }
            }
        }
        .navigationTitle("Space")
    }
}

struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceView(store: Space.defaultStore)
    }
}
