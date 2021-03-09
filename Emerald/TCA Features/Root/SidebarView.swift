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
                Section(header: Text("Settings")) {
                    NavigationLink(
                        destination: SpaceSettingsView(
                            store: store.scope(
                                state: \.yabai,
                                action: Root.Action.yabai
                            )
                        )
                    ) {
                        Label("Space", systemImage: "rectangle.3.offgrid")
                    }
                    NavigationLink(
                        destination: WindowSettingsView(
                            store: store.scope(
                                state: \.yabai,
                                action: Root.Action.yabai
                            )
                        )
                    ) {
                        Label("Window", systemImage: "macwindow.on.rectangle")
                    }
                    NavigationLink(
                        destination: NewWindowSettings(
                            store: store.scope(
                                state: \.yabai,
                                action: Root.Action.yabai
                            )
                        )
                    ) {
                        Label("New Window", systemImage: "macwindow.badge.plus")
                    }

                    NavigationLink(
                        destination: MouseSettingsView(
                            store: store.scope(
                                state: \.yabai,
                                action: Root.Action.yabai
                            )
                        )
                    ) {
                        Label("Mouse", systemImage: "cursorarrow")
                    }
                    NavigationLink(
                        destination: FocusSettingsView(
                            store: store.scope(
                                state: \.yabai,
                                action: Root.Action.yabai
                            )
                        )
                    ) {
                        Label("Focus", systemImage: "cursorarrow.motionlines")
                    }
                    NavigationLink(
                        destination: ExternalBarSettingsView(
                            store: store.scope(
                                state: \.yabai,
                                action: Root.Action.yabai
                            )
                        )
                    ) {
                        Label("Menu Bar", systemImage: "rectangle.topthird.inset")
                    }
                }
                Spacer()
                //                Section(header: Text("Debug")) {
                //                    NavigationLink(
                //                        destination: DebugYabaiView(
                //                            store: store.scope(
                //                                state: \.yabai,
                //                                action: Root.Action.yabai
                //                            )
                //                        )
                //                    ) {
                //                        Label("Debug Yabai", systemImage: "macwindow")
                //                    }
                //                    NavigationLink(
                //                        destination: DebugSKHDSettingsView(
                //                                                        store: store.scope(
                //                                                            state: \.skhd,
                //                                                            action: Root.Action.skhd
                //                                                        )
                //                        )
                //                    ) {
                //                        Label("Debug SKHD", systemImage: "keyboard")
                //                    }
                //                    NavigationLink(
                //                        destination: MacOSAnimationSettingsView(
                //                            store: store.scope(
                //                                state: \.macOSAnimations,
                //                                action: Root.Action.macOSAnimations
                //                            )
                //                        )
                //                    ) {
                //                        Label("Debug Animations", systemImage: "stopwatch")
                //                    }
                //                    NavigationLink(
                //                        destination: SystemIntegrityProtectionView()
                //                    ) {
                //                        Label("System Integrity Protection", systemImage: "lock")
                //                    }
                //                }
                //                Divider()
                Section(header: Text("Other")) {
                    NavigationLink(
                        destination: AboutView(
                            store: store
                        )
                    ) {
                        Label("About", systemImage: "gear")
                    }
                }
                Spacer()
            }
            .listStyle(SidebarListStyle())
        }
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
