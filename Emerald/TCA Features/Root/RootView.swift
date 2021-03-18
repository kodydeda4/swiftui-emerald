//
//  RootView.swift
//  Emerald
//
//  Created by Kody Deda on 2/12/21.
//

import SwiftUI
import ComposableArchitecture

// off/on switch still buggy

struct RootView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                SidebarView(store: store)
                SpaceSettingsView(store: store.scope(state: \.yabai, action: Root.Action.yabai))
                //ConfigTabView(store: store)
            }
            .disabled(!viewStore.enabled)
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
            .sheet(isPresented: viewStore.binding(get: \.togglingActive, send: .togglingActive)) {
                TogglingActiveView(store: store)
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
                    .help("Toggle SIP Lock")
                    .foregroundColor(viewStore.yabai.sipEnabled && viewStore.enabled ? .accentColor : .gray)
                    .opacity(viewStore.yabai.sipEnabled && viewStore.enabled ? 1 : 0.5)
                    .disabled(!viewStore.enabled)
                }
                ToolbarItem {
                    Button<Image>("keyboard") {
                        viewStore.send(.skhd(.toggleIsEnabled))
                    }
                    .help("Toggle Keyboard Shortcuts")
                    .foregroundColor(viewStore.skhd.isEnabled && viewStore.enabled ? .accentColor : .gray)
                    .opacity(viewStore.skhd.isEnabled && viewStore.enabled ? 1 : 0.5)
                    .disabled(!viewStore.enabled)
                }
//                ToolbarItem {
//                    Button<Image>("timer") {
//                        viewStore.send(.export(.macOSAnimations))
//                        viewStore.send(.macOSAnimations(.executeShellScript))
//                    }
//                    .help("Apply Animation Changes")
//                    .foregroundColor(viewStore.enabled ? .accentColor : .gray)
//                    .opacity(viewStore.enabled ? 1 : 0.5)
//                    .disabled(!viewStore.enabled)
//                }
                ToolbarItem {
                    Button("Reset") {
                        viewStore.send(.showResetAlert)
                    }
                    .help("⇧ ⌘ R")
                    .keyboardShortcut("r", modifiers: [.command, .shift])
                    .disabled(!viewStore.enabled)
                }
                ToolbarItem {
                    Button("Apply Changes") {
                        viewStore.send(.toggleApplyingChanges)
                        viewStore.send(.export(.yabai))
                        viewStore.send(.export(.skhd))
                        viewStore.send(.homebrew(.restartYabai))
                    }
                    .help("⇧ ⌘ A")
                    .keyboardShortcut("a", modifiers: [.command, .shift])
                    .disabled(!viewStore.enabled)
                }
                ToolbarItem {
                    Button<Image>("power") {
//                        viewStore.send(.powerButtonTapped)
                        viewStore.send(.toggleEnabled)
                        viewStore.send(.togglingActive)
                    }
                    .help("\(viewStore.enabled ? "Disable" : "Enable") Emerald")
                    .foregroundColor(viewStore.enabled && viewStore.enabled ? .accentColor : .red)
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
