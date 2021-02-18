//
//  AnimationsView.swift
//  AnimationUI
//
//  Created by Kody Deda on 2/18/21.
//


import SwiftUI
import ComposableArchitecture

struct AnimationSettingsView: View {
    let store: Store<AnimationSettings.State, AnimationSettings.Action>
    let keyPath = AnimationSettings.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                ConfigFileView(text: viewStore.asConfig)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        SectionView("Animations") {
                            Toggle("Enable All", isOn: viewStore.binding(keyPath: \.allEnabled, send: keyPath))
                        }
                    }
                }
            }
            .navigationTitle("Debug Animations")
        }
    }
}

// MARK:- AnimationSettingsView_Previews

struct AnimationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationSettingsView(store: AnimationSettings.defaultStore)
    }
}
