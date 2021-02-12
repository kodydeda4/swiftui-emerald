//
//  SpaceSettingsView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

//struct SpaceSettingsView: View {
//    let store: Store<Root.State, Root.Action>
//
//    var body: some View {
//        List {
//            Section(header: Text("Yabai Settings")) {
//                YabaiSpaceSettingsView(store: store.scope(
//                            state: \.space,
//                            action: Root.Action.space))
//            }
//            Divider()
//            Section(header: Text("SKHD Settings")) {
//                SKHDSpaceSettingsView(store: store.scope(
//                            state: \.skhd,
//                            action: Root.Action.skhd))
//            }
//        }
//        .navigationTitle("Space")
//    }
//}

struct SpaceSettingsView: View {
    let store: Store<Space.State, Space.Action>
    @State var errorMessage: String = ""
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Text(errorMessage)
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
        .navigationTitle("Space")
    }
}

//struct SKHDSpaceSettingsView: View {
//    let store: Store<SKHD.State, SKHD.Action>
//
//    var body: some View {
//        WithViewStore(store) { viewStore in
//            VStack {
//                HStack {
//                    Text("Example")
//                    TextField("Untitled", text: viewStore.binding(
//                        get: \.skhdString,
//                        send: SKHD.Action.updateSKHDString
//                    ))
//                }
//            }
//        }
//    }
//}

//struct SKHDSpaceSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SKHDSpaceSettingsView(store: SKHD.defaultStore)
//    }
//}


struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Space.defaultStore)
    }
}
