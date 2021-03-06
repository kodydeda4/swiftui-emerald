//
//  AnimationsView.swift
//  Emerald
//
//  Created by Kody Deda on 2/18/21.
//


import SwiftUI
import ComposableArchitecture

struct MacOSAnimationSettingsView: View {
    let store: Store<MacOSAnimations.State, MacOSAnimations.Action>
    let k = MacOSAnimations.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            HStack {
                DebugConfigFileView(text: vs.asConfig)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        SectionView("Animations") {
                            Toggle("Enable All", isOn: vs.binding(keyPath: \.allEnabled, send: k))
                        }
                    }
                }
            }
            .navigationTitle("Debug Animations")
        }
    }
}

// MARK:- SwiftUI Previews

struct MacOSAnimationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MacOSAnimationSettingsView(store: MacOSAnimations.defaultStore)
    }
}
