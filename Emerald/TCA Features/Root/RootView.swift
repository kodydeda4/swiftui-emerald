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
            .sheet(isPresented: viewStore.binding(get: \.onboarding.isOnboaring, send: .onboarding(.toggleIsOnboaring))) {
                OnboardingView(store: store.scope(state: \.onboarding, action: Root.Action.onboarding))
            }
            .sheet(isPresented: viewStore.binding(get: \.applyingChanges, send: .toggleApplyingChanges)) {
                ApplyingChangesView(store: store)
            }
            .alert(store.scope(state: \.alert), dismiss: .dismissResetAlert)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button<Image>("sidebar.left") {
                        toggleSidebar()
                    }
                }
                ToolbarItem {
                    Button<Image>("lock.fill") {
                        viewStore.send(.yabai(.toggleSIP))
                    }
                    .foregroundColor(viewStore.yabai.sipEnabled ? .accentColor : .gray)
                    .opacity(viewStore.yabai.sipEnabled ? 1 : 0.5)
                    .help("Toggle SIP Lock")
                }
                ToolbarItem {
                    Button<Image>("keyboard") {
                        viewStore.send(.skhd(.toggleIsEnabled))
                    }
                    .foregroundColor(viewStore.skhd.isEnabled ? .accentColor : .gray)
                    .opacity(viewStore.skhd.isEnabled ? 1 : 0.5)
                    .help("Toggle Keyboard Shortcuts")
                }
                ToolbarItem {
                    Button("Reset") {
                        viewStore.send(.showResetAlert)
                    }
                    .help("⇧ ⌘ R")
                    .keyboardShortcut("r", modifiers: [.command, .shift])
                }
                ToolbarItem {
                    Button("Apply Changes") {
                        viewStore.send(.toggleApplyingChanges)
                        viewStore.send(.export(.yabai))
                        viewStore.send(.export(.skhd))
                        viewStore.send(.appleScript(.brewServicesRestartYabai))
                    }
                    .help("⇧ ⌘ A")
                    .keyboardShortcut("a", modifiers: [.command, .shift])
                }
                //                ToolbarItem {
                //                    Button("Apply Animation Changes") {
                //                        viewStore.send(.export(.macOSAnimations))
                //                        let _ = AppleScript.applyAnimationSettings.execute()
                //                    }
                //                }
            }
        }
    }
}




struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Root.defaultStore)
    }
}
