//
//  SKHDSettingsView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/17/21.
//

import SwiftUI
import ComposableArchitecture

struct SKHDSettingsView: View {
    let store: Store<SKHDSettings.State, SKHDSettings.Action>
    let keyPath = SKHDSettings.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading) {
                Text("SKHD Configuration")
                    .font(.title)
                
                TextField("", text: .constant(viewStore.asConfig))
                
                    HStack {
                        Text("togglePadding")
                        TextField("", text: .constant(viewStore.togglePadding))
                    }
                    HStack {
                        Text("togglePadding")
                        TextField("", text: .constant(viewStore.togglePadding))
                    }
                    HStack {
                        Text("toggleBalance")
                        TextField("", text: .constant(viewStore.toggleBalance))
                    }
                    HStack {
                        Text("toggleStacking")
                        TextField("", text: .constant(viewStore.toggleStacking))
                    }
                    HStack {
                        Text("toggleFloating")
                        TextField("", text: .constant(viewStore.toggleFloating))
                    }
                    HStack {
                        Text("toggleBSP")
                        TextField("", text: .constant(viewStore.toggleBSP))
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Space")
    }
}

struct SKHDSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SKHDSettingsView(store: SKHDSettings.defaultStore)
    }
}

