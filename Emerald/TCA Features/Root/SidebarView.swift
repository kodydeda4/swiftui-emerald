//
//  SidebarView.swift
//  Emerald
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

struct SidebarView: View {
    let store: Store<Root.State, Root.Action>

    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Section(header: Text("Debug")) {
                    NavigationLink(destination: YabaiSettingsView(
                        store: store
                            .scope(state: \.yabai, action: Root.Action.yabai)
                            .scope(state: \.yabaiSettings, action: Yabai.Action.yabaiSettings)
                    )) {
                        Label("Debug Yabai", systemImage: "terminal")
                    }
                    NavigationLink(destination: SKHDSettingsView(
                        store: store
                            .scope(state: \.skhd, action: Root.Action.skhd)
                            .scope(state: \.skhdSettings, action: SKHD.Action.skhdSettings)
                    )) {
                        Label("Debug SKHD", systemImage: "keyboard")
                    }
                    NavigationLink(destination: AnimationSettingsView(
                        store: store
                            .scope(state: \.animationSettings, action: Root.Action.animationSettings)
                    )) {
                        Label("Debug Animations", systemImage: "arrowtriangle.forward")
                    }
                    NavigationLink(destination: SystemIntegrityProtectionView()) {
                        Label("System Integrity Protection", systemImage: "lock.circle")
                    }
                }
                Divider()
                NavigationLink(destination: AboutView(
                    store: store
                )) {
                    Label("About", systemImage: "gear")
                }
            }
        }
        .listStyle(SidebarListStyle())
    }
}

// MARK:- SwiftUI Previews

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(store: Root.defaultStore)
    }
}
