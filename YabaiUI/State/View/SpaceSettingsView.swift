//
//  SpaceSettingsView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

struct SpaceSettingsView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        List {
            Section(header: Text("Yabai Settings")) {
                YabaiSpaceSettingsView(store: store.scope(
                            state: \.yabai,
                            action: Root.Action.yabai))
            }
            Divider()
            Section(header: Text("SKHD Settings")) {
                SKHDSpaceSettingsView(store: store.scope(
                            state: \.skhd,
                            action: Root.Action.skhd))
            }
        }
        .navigationTitle("Space")
    }
}

struct YabaiSpaceSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    @State var errorMessage: String = ""
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Text(errorMessage)
                Picker("Layout", selection:
                        viewStore.binding(
                            get: \.layout,
                            send: Yabai.Action.updateLayout)
                ) {
                    ForEach(Yabai.State.Layout.allCases) {
                        Text($0.rawValue)
                    }
                }
                HStack {
                    Text("Top Padding")
                    TextField(
                        "",
                        value: viewStore.binding(
                            get: \.paddingTop,
                            send: Yabai.Action.updatePaddingTop),
                        formatter: NumberFormatter()
                    )
                }
                HStack {
                    Text("Bottom Padding")
                    TextField(
                        "",
                        value: viewStore.binding(
                            get: \.paddingBottom,
                            send: Yabai.Action.updatePaddingBottom
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
                            send: Yabai.Action.updatePaddingLeft),
                        formatter: NumberFormatter()
                    )
                }
                HStack {
                    Text("Right Padding")
                    TextField(
                        "",
                        value: viewStore.binding(
                            get: \.paddingRight,
                            send: Yabai.Action.updatePaddingRight
                        ),
                        formatter: NumberFormatter()
                    )
                }
            }
        }
    }
}

struct SKHDSpaceSettingsView: View {
    let store: Store<SKHD.State, SKHD.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                HStack {
                    Text("Example")
                    TextField("Untitled", text: viewStore.binding(
                        get: \.skhdString,
                        send: SKHD.Action.updateSKHDString
                    ))
                }
            }
        }
    }
}

struct SKHDSpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SKHDSpaceSettingsView(store: SKHD.defaultStore)
    }
}


struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Root.defaultStore)
    }
}
