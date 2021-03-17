//
//  RootView.swift
//  Emerald
//
//  Created by Kody Deda on 2/12/21.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                SidebarView(store: store)
                SpaceSettingsView(store: store.scope(state: \.yabai, action: Root.Action.yabai))
                //ConfigTabView(store: store)
            }
            .frame(width: 800, height: 700)
            .onAppear {
                viewStore.send(.load(.yabai))
                viewStore.send(.load(.skhd))
                viewStore.send(.load(.macOSAnimations))
            }
            .sheet(
                isPresented:
                    viewStore.binding(
                        get: \.onboarding.isOnboaring,
                        send: .onboarding(.toggleIsOnboaring))
            ) {
                OnboardingView(
                    store: store.scope(state: \.onboarding, action: Root.Action.onboarding)
                )
            }
            .sheet(
                isPresented:
                    viewStore.binding(
                        get: \.applyingChanges,
                        send: .applyingChanges)
            ) {
                ApplyingChangesView(
                    store: store
                )
            }

            .alert(store.scope(state: \.alert), dismiss: .cancelResetSettingsAlert)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: toggleSidebar) {
                        Image(systemName: "sidebar.left")
                    }
                }
                //                ToolbarItem {
                //                    Button("Apply Animation Changes") {
                //                        viewStore.send(.export(.macOSAnimations))
                //                        let _ = AppleScript.applyAnimationSettings.execute()
                //                    }
                //                }
                ToolbarItem {
                    Button(action: {
                        viewStore.send(.yabai(.toggleSIP))
                    }) {
                        Image(systemName: "lock.fill")
                            .foregroundColor(viewStore.yabai.sipEnabled ? .accentColor : .gray)
                            .opacity(viewStore.yabai.sipEnabled ? 1 : 0.5)
                            
                    }
                    .help("Toggle SIP Lock")
                }
                
                ToolbarItem {
                    Button(action: {
                        viewStore.send(.skhd(.toggleIsEnabled))
                    }) {
                        Image(systemName: "keyboard")
                            .foregroundColor(viewStore.skhd.isEnabled ? .accentColor : .gray)
                            .opacity(viewStore.skhd.isEnabled ? 1 : 0.5)
                            
                    }
                    .help("Toggle Keyboard Shortcuts")
                    //.keyboardShortcut("a", modifiers: [.command, .shift])
                }

                ToolbarItem {
                    Button(action: {
                        viewStore.send(.showResetSettingsAlert)
                    }) {
                        Text("Reset")
                    }
                    .help("⇧ ⌘ R")
                    .keyboardShortcut("r", modifiers: [.command, .shift])
                }
                ToolbarItem {
                    Button(action: {
                        viewStore.send(.applyingChanges)
                        viewStore.send(.export(.yabai))
                        viewStore.send(.export(.skhd))
                        //viewStore.send(.appleScript(.restartYabai))
                        viewStore.send(.appleScript(.brewServicesRestartYabai))
                    }) {
                        Text("Apply Changes")
                    }
                    .help("⇧ ⌘ A")
                    .keyboardShortcut("a", modifiers: [.command, .shift])
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Root.defaultStore)
    }
}
