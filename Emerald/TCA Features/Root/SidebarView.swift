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
    
    var yabaiStore: Store<Yabai.State, Yabai.Action> {
        store.scope(state: \.yabai, action: Root.Action.yabai)
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                NavigationLink(destination: SpaceSettingsView(store: store)) {
                    Label("Space", systemImage: "rectangle.3.offgrid")
                }
                NavigationLink(destination: WindowSettingsView(store: yabaiStore)) {
                    Label("Window", systemImage: "macwindow.on.rectangle")
                }
                NavigationLink(destination: PlacementSettingsView(store: yabaiStore)) {
                    Label("Placement", systemImage: "macwindow.badge.plus")
                }
                NavigationLink(destination: MouseSettingsView(store: yabaiStore)) {
                    Label("Mouse", systemImage: "cursorarrow")
                }
                NavigationLink(destination: FocusSettingsView(store: yabaiStore)) {
                    Label("Focus", systemImage: "cursorarrow.motionlines")
                }
            }
            .listStyle(SidebarListStyle())
        }
    }
}



// MARK:- SwiftUI Previews
struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(store: Root.defaultStore)
    }
}
