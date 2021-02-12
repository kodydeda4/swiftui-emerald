//
//  YabaiSpaceSettingsView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture


struct YabaiSpaceSettingsView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        List {
            Section(header: Text("Yabai Settings")) {
                YabaiView(store: store.scope(
                            state: \.yabai,
                            action: Root.Action.yabai))
            }
            Divider()
            Section(header: Text("SKHD Settings")) {
                SKHDView(store: store.scope(
                            state: \.skhd,
                            action: Root.Action.skhd))
            }
        }
        .navigationTitle("YabaiUI - Space Settings")
    }
}

struct YabaiSpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        YabaiSpaceSettingsView(store: Root.defaultStore)
    }
}
