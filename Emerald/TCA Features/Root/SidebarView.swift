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
                Section(header: Text("Yabai")) {
                    NavigationLink(
                        destination: SpaceSettingsView(
                            store: store.scope(
                                state: \.yabai,
                                action: Root.Action.yabai
                            )
                        )
                    ) {
                        Label("SpaceSettingsView", systemImage: "macwindow")
                    }
                    NavigationLink(
                        destination: WindowSettingsView(
                            store: store.scope(
                                state: \.yabai,
                                action: Root.Action.yabai
                            )
                        )
                    ) {
                        Label("WindowSettingsView", systemImage: "macwindow")
                    }
                    NavigationLink(
                        destination: MouseSettingsView(
                            store: store.scope(
                                state: \.yabai,
                                action: Root.Action.yabai
                            )
                        )
                    ) {
                        Label("MouseSettingsView", systemImage: "macwindow")
                    }
                    NavigationLink(
                        destination: ExternalBarSettingsView(
                            store: store.scope(
                                state: \.yabai,
                                action: Root.Action.yabai
                            )
                        )
                    ) {
                        Label("ExternalBarSettingsView", systemImage: "macwindow")
                    }
                }
                Divider()                
                Section(header: Text("Debug")) {
                    NavigationLink(
                        destination: DebugYabaiView(
                            store: store.scope(
                                state: \.yabai,
                                action: Root.Action.yabai
                            )
                        )
                    ) {
                        Label("Debug Yabai", systemImage: "macwindow")
                    }
                    NavigationLink(
                        destination: DebugSKHDSettingsView(
                                                        store: store.scope(
                                                            state: \.skhd,
                                                            action: Root.Action.skhd
                                                        )
                        )
                    ) {
                        Label("Debug SKHD", systemImage: "keyboard")
                    }
                    NavigationLink(
                        destination: MacOSAnimationSettingsView(
                            store: store.scope(
                                state: \.macOSAnimations,
                                action: Root.Action.macOSAnimations
                            )
                        )
                    ) {
                        Label("Debug Animations", systemImage: "stopwatch")
                    }
                    NavigationLink(
                        destination: SystemIntegrityProtectionView()
                    ) {
                        Label("System Integrity Protection", systemImage: "lock")
                    }
                }
                Divider()
                NavigationLink(
                    destination: AboutView(
                        store: store
                    )
                ) {
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
