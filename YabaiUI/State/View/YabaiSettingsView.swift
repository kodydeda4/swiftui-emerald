//
//  SpaceSettingsView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

struct YabaiSettingsView: View {
    let store: Store<YabaiSettings.State, YabaiSettings.Action>
    let keyPath = YabaiSettings.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading) {
                Text("Yabai Configuration")
                    .font(.title)
                
                TextField("", text: .constant(viewStore.asConfig))
                
                Picker("Layout", selection: viewStore.binding(keyPath: \.layout, send: keyPath)) {
                    ForEach(YabaiSettings.State.Layout.allCases) {
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
                HStack {
                    Text("Window Gap")
                    TextField("", value: viewStore.binding(keyPath: \.windowGap, send: keyPath), formatter: NumberFormatter())
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Space")
    }
}

struct YabaiSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        YabaiSettingsView(store: YabaiSettings.defaultStore)
    }
}

