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
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Section(header: Text("Layout & Padding")) {
                    //Text(errorMessage)
                    Picker("Layout", selection:
                            viewStore.binding(
                                get: \.layout,
                                send: Space.Action.updateLayout)
                    ) {
                        ForEach(Space.State.Layout.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    HStack {
                        Text("Top Padding")
                        TextField(
                            "",
                            value: viewStore.binding(
                                get: \.paddingTop,
                                send: Space.Action.updatePaddingTop),
                            formatter: NumberFormatter()
                        )
                    }
                    HStack {
                        Text("Bottom Padding")
                        TextField(
                            "",
                            value: viewStore.binding(
                                get: \.paddingBottom,
                                send: Space.Action.updatePaddingBottom
                            ),
                            formatter: NumberFormatter()
                        )
                    }
                    HStack {
                        Text("Left Padding")
                        TextField(
                            "",
                            value: viewStore.binding(
                                get: \.paddingLeft,
                                send: Space.Action.updatePaddingLeft),
                            formatter: NumberFormatter()
                        )
                    }
                    HStack {
                        Text("Right Padding")
                        TextField(
                            "",
                            value: viewStore.binding(
                                get: \.paddingRight,
                                send: Space.Action.updatePaddingRight
                            ),
                            formatter: NumberFormatter()
                        )
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
