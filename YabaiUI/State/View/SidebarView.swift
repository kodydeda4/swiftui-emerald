//
//  SidebarView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/11/21.
//

import ComposableArchitecture
import SwiftUI

struct SidebarView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Section(header: Text("Settings")) {
                    SettingsNavlinks(
                        store: store.scope(
                            state: \.settingsManager,
                            action: Root.Action.settingsManager
                        )
                    )
                }
                //Label("Rule", systemImage: "keyboard")
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

private struct SettingsNavlinks: View {
    let store: Store<SettingsManager.State, SettingsManager.Action>
    
    var body: some View {
        NavigationLink(destination: YabaiSettingsView(store: store.scope(state: \.yabaiSettings, action: SettingsManager.Action.yabaiSettings))) {
            Label("Space", systemImage: "rectangle.3.offgrid")
        }
    }
}

struct TemporaryTextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .foregroundColor(Color(NSColor.placeholderTextColor))
    }
}

// MARK:- SwiftUI Previews

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(store: Root.defaultStore)
    }
}
