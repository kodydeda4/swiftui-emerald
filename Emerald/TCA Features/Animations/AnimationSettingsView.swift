//
//  AnimationsView.swift
//  Emerald
//
//  Created by Kody Deda on 2/18/21.
//


import SwiftUI
import ComposableArchitecture

struct AnimationSettingsView: View {
    let store: Store<MacOSAnimations.State, MacOSAnimations.Action>
    let keyPath = MacOSAnimations.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                DebugConfigFileView(text: viewStore.asConfig)
                
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
        AnimationSettingsView(store: MacOSAnimations.defaultStore)
    }
}
