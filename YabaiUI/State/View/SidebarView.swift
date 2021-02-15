//
//  SidebarView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/11/21.
//

import ComposableArchitecture
import SwiftUI

struct SidebarView: View {
    let store: Store<Yabai.State, Yabai.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Section(header: Text("Settings")) {
                    NavigationLink(destination: ConfigView(store: store.scope(state: \.config, action: Yabai.Action.config))) {
                        Label("Config", systemImage: "rectangle.3.offgrid")
                    }
                    NavigationLink(destination: TemporaryTextView(text: "Display")) {
                        Label("Display", systemImage: "display")
                    }
                    NavigationLink(destination: SpaceView(store: store.scope(state: \.space, action: Yabai.Action.space))) {
                        Label("Space", systemImage: "rectangle.3.offgrid")
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
        SidebarView(store: Yabai.defaultStore)
    }
}
