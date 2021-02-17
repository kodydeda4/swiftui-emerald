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
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Text(viewStore.asConfigFile)
                Section(header: Text("Layout & Padding")) {
                    Picker("Layout", selection: viewStore.binding(get: \.layout, send: YabaiSettings.Action.updateLayout)) {
                        ForEach(YabaiSettings.State.Layout.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    HStack {
                        Text("Top Padding")
                        TextField("", value: viewStore.binding(get: \.paddingTop, send: YabaiSettings.Action.updatePaddingTop), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Bottom Padding")
                        TextField("", value: viewStore.binding(get: \.paddingBottom, send: YabaiSettings.Action.updatePaddingBottom), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Left Padding")
                        TextField("", value: viewStore.binding(get: \.paddingLeft, send: YabaiSettings.Action.updatePaddingLeft), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Right Padding")
                        TextField("", value: viewStore.binding(get: \.paddingRight, send: YabaiSettings.Action.updatePaddingRight), formatter: NumberFormatter())
                    }
                    HStack {
                        Text("Window Gap")
                        TextField("", value: viewStore.binding(get: \.windowGap, send: YabaiSettings.Action.updateWindowGap), formatter: NumberFormatter())
                    }
                }
            }
        }
        .navigationTitle("Space")
    }
}

struct YabaiSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        YabaiSettingsView(store: YabaiSettings.defaultStore)
    }
}
