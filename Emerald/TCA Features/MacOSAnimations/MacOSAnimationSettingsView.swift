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
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading) {
                SectionView("Animations") {
                    Toggle("Enabled", isOn: vs.binding(get: \.enabled, send: .toggleEnabled))
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
