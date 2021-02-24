//
//  SidebarView.swift
//  YabaiUI
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
                            .scope(state: \.dataManager, action: Root.Action.dataManager)
                            .scope(state: \.yabaiSettings, action: DataManager.Action.yabaiSettings)
                    )) {
                        Label("Yabai Debug", systemImage: "terminal")
                    }
                    NavigationLink(destination: SKHDSettingsView(
                        store: store
                            .scope(state: \.dataManager, action: Root.Action.dataManager)
                            .scope(state: \.skhdSettings, action: DataManager.Action.skhdSettings)
                    )) {
                        Label("SKHD Debug", systemImage: "keyboard")
                    }
                    NavigationLink(destination: AnimationSettingsView(
                        store: store
                            .scope(state: \.dataManager, action: Root.Action.dataManager)
                            .scope(state: \.animationSettings, action: DataManager.Action.animationSettings)
                    )) {
                        Label("Animations Debug", systemImage: "keyboard")
                    }
                }
                Divider()
                NavigationLink(destination: AboutView(store: store)) {
                    Label("About", systemImage: "gear")
                }
            }
        }
        .listStyle(SidebarListStyle())
    }
}

func toggleSidebar() {
    NSApp.keyWindow?
        .firstResponder?
        .tryToPerform(
            #selector(NSSplitViewController.toggleSidebar),
            with: nil
        )
}

// MARK:- SwiftUI Previews

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(store: Root.defaultStore)
    }
}
