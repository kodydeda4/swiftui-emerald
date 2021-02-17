//
//  RootView.swift
//  YabaiUI
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
            
            .onAppear { viewStore.send(.settingsManager(.loadYabaiSettings)) }
            .sheet(isPresented:
                    viewStore.binding(
                        get: \.onboarding.isOnboaring,
                        send: Root.Action.onboarding(.toggleIsOnboaring))
            ) {
                OnboardingView(
                    store: store.scope(
                        state: \.onboarding,
                        action: Root.Action.onboarding
                    )
                )
            }
            .toolbar {
                ToolbarItem {
                    Button("Export Data") {
                        viewStore.send(.configManager(.exportConfigs))
                    }
                }
                ToolbarItem {
                    Button("Toggle OnboardingView") {
                        viewStore.send(.onboarding(.toggleIsOnboaring))
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


