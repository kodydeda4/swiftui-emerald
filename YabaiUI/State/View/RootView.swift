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
                VStack {
                    Text("Welcome Page")
                        .font(.largeTitle)
                        .foregroundColor(Color(NSColor.placeholderTextColor))
                }
            }
            .onAppear { viewStore.send(.load) }
            .sheet(isPresented: viewStore.binding(
                    get: \.displayingOnboard,
                    send: Root.Action.toggleDisplayingOnboard)
            ) {
                OnboardingView(store: store.scope(
                            state: \.onboarding,
                            action: Root.Action.onboarding))
            }
            .toolbar {
                ToolbarItem {
                    Button("Export Data") {
                        viewStore.send(.exportConfigs)
                    }
                }
                ToolbarItem {
                    Button("Toggle OnboardingView") {
                        viewStore.send(.toggleDisplayingOnboard)
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
