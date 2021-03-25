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
            .disabled(viewStore.disabled)
            .onAppear {
                viewStore.send(.onAppear)
            }
            .sheet(isPresented: viewStore.binding(get: \.sheetView, send: .toggleSheetView)) {
                SheetView(store: store)
            }
//            .sheet(isPresented: viewStore.binding(get: \.onboarding.isOnboaring, send: .onboarding(.toggleIsOnboaring))) {
//                OnboardingView(store: store.scope(state: \.onboarding, action: Root.Action.onboarding))
//            }
            .alert(store.scope(state: \.alert), dismiss: .dismissResetAlert)
            .toolbar {
                ToolbarItem {
                    Button<Image>("sidebar.left") {
                        viewStore.send(.sidebarButtonTapped)
                    }
                    .disabled(viewStore.disabled)
                }
                ToolbarItem {
                    Button<Image>("lock.fill") {
                        viewStore.send(.lockButtonTapped)
                    }
                    .help("Toggle SIP Lock")
                    .foregroundColor(viewStore.yabai.sipEnabled && !viewStore.disabled ? .accentColor : .gray)
                    .opacity(viewStore.yabai.sipEnabled && !viewStore.disabled ? 1 : 0.5)
                    .disabled(viewStore.disabled)
                }
                ToolbarItem {
                    Button<Image>("keyboard") {
                        viewStore.send(.keyboardButtonTapped)
                    }
                    .help("Toggle Keyboard Shortcuts")
                    .foregroundColor(viewStore.homebrew.skhdRunning && !viewStore.disabled ? .accentColor : .gray)
                    .opacity(viewStore.homebrew.skhdRunning && !viewStore.disabled ? 1 : 0.5)
                    .disabled(viewStore.disabled)
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
                        viewStore.send(.resetButtonTapped)
                    }
                    .help("⇧ ⌘ R")
                    .keyboardShortcut("r", modifiers: [.command, .shift])
                    .disabled(viewStore.disabled)
                }
                ToolbarItem {
                    Button("Apply Changes") {
                        viewStore.send(.applyChangesButtonTapped)
                    }
                    .help("⇧ ⌘ A")
                    .keyboardShortcut("a", modifiers: [.command, .shift])
                    .disabled(viewStore.disabled)
                }
                ToolbarItem {
                    Button<Image>("power") {
                        viewStore.send(.powerButtonTapped)
                    }
                    .help("\(viewStore.disabled ? "Enable" : "Disable") Emerald")
                    .foregroundColor(viewStore.disabled ? .red : .accentColor)
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
