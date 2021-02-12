//
//  Sidebar.swift
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
                    // Links
                    NavigationLink(destination: YabaiSpaceSettingsView(store: store)) {
                        Label("Space", systemImage: "rectangle.3.offgrid").accentColor(.purple)
                    }
                    .navigationSubtitle("Space")
                    
                    Divider()
                    
                    NavigationLink(destination: AboutView(store: store)) {
                        Label("About", systemImage: "ellipsis").accentColor(.purple)
                    }
                    .navigationSubtitle("About")
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
