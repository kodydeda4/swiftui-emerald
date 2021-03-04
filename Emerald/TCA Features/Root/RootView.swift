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
                
                Text("Welcome Page")
                    .font(.largeTitle)
                    .foregroundColor(Color(NSColor.placeholderTextColor))
            }
            .onAppear {
                viewStore.send(.load(.yabai))
                viewStore.send(.load(.skhd))
                viewStore.send(.load(.macOSAnimations))
            }
            .sheet(
                isPresented:
                    viewStore.binding(
                        get: \.onboarding.isOnboaring,
                        send: Root.Action.onboarding(.toggleIsOnboaring))
            ) {
                OnboardingView(
                    store: store.scope(state: \.onboarding, action: Root.Action.onboarding)
                )
            }
            .toolbar {
                ToolbarItem {
                    Button("Toggle OnboardingView") {
                        viewStore.send(.onboarding(.toggleIsOnboaring))
                    }
                }
                ToolbarItem {
                    Button("Apply Animation Changes") {
                        viewStore.send(.export(.macOSAnimations))
                        let _ = AppleScript.applyAnimationSettings.execute()
                    }
                }
                ToolbarItem {
                    Button("Reset Yabai Settings") {
                        viewStore.send(.reset(.yabai))
                    }
                }
                ToolbarItem {
                    Button("Apply Changes") {
                        viewStore.send(.export(.yabai))
                        viewStore.send(.export(.skhd))
                        
                        let _ = AppleScript.restartYabai.execute()
                    }
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
