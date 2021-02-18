//
//  SettingsView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/17/21.
//

import SwiftUI
import ComposableArchitecture

struct DataManagerView: View {
    let store: Store<DataManager.State, DataManager.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            //
        }
    }
}
