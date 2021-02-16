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
                            state: \.yabaiConfiguration,
                            action: Root.Action.yabaiConfiguration
                        )
                    )
                }
                Divider()
                Section(header: Text("Actions")) {
                    NavigationLink(destination: TemporaryTextView(text: "Display")) {
                        Label("Display", systemImage: "display")
                    }
                    NavigationLink(destination: TemporaryTextView(text: "Window")) {
                        Label("Window", systemImage: "macwindow")
                    }
                    NavigationLink(destination: TemporaryTextView(text: "Query")) {
                        Label("Query", systemImage: "terminal")
                    }
                    NavigationLink(destination: TemporaryTextView(text: "Rule")) {
                        Label("Rule", systemImage: "keyboard")
                    }
                    NavigationLink(destination: TemporaryTextView(text: "Signal")) {
                        Label("Signal", systemImage: "antenna.radiowaves.left.and.right")
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




private struct SettingsNavlinks: View {
    let store: Store<YabaiConfiguration.State, YabaiConfiguration.Action>
    
    var body: some View {
        NavigationLink(destination: GlobalSettingsView(store: store.scope(state: \.globalSettings, action: YabaiConfiguration.Action.globalSettings))) {
            Label("Global", systemImage: "globe")
        }
        NavigationLink(destination: SpaceSettingsView(store: store.scope(state: \.spaceSettings, action: YabaiConfiguration.Action.spaceSettings))) {
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
