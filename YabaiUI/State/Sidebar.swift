//
//  Sidebar.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/11/21.
//

import ComposableArchitecture
import SwiftUI

struct UnderConstructionView: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        VStack {
            Text(text)
                .font(.largeTitle)
                .foregroundColor(Color(NSColor.placeholderTextColor))
        }
    }
}

struct SidebarView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Section(header: Text("Settings")) {
                    NavigationLink(destination: UnderConstructionView("Config")) {
                        Label("Config", systemImage: "slider.horizontal.3")
                    }
                    NavigationLink(destination: UnderConstructionView("Display")) {
                        Label("Display", systemImage: "display")
                    }
                    NavigationLink(destination: YabaiSpaceSettingsView(store: store)) {
                        Label("Space", systemImage: "rectangle.3.offgrid")
                    }
                    NavigationLink(destination: UnderConstructionView("Window")) {
                        Label("Window", systemImage: "macwindow")
                    }
                    NavigationLink(destination: UnderConstructionView("Query")) {
                        Label("Query", systemImage: "terminal")
                    }
                    NavigationLink(destination: UnderConstructionView("Rule")) {
                        Label("Rule", systemImage: "keyboard")
                    }
                    NavigationLink(destination: UnderConstructionView("Signal")) {
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
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar), with: nil)
}

// MARK:- SwiftUI Previews

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(store: Root.defaultStore)
    }
}
