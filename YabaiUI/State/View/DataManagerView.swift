//
//  SettingsView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/17/21.
//

import SwiftUI
import ComposableArchitecture
import KeyboardShortcuts




struct DataManagerView: View {
    let store: Store<DataManager.State, DataManager.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                YabaiSettingsView(store: store.scope(state: \.yabaiSettings, action: DataManager.Action.yabaiSettings))
                SKHDSettingsView(store: store.scope(state: \.skhdSettings, action: DataManager.Action.skhdSettings))
            }
        }
    }
}
