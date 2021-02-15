//
//  RootView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/12/21.
//

import SwiftUI
import ComposableArchitecture

//struct YabaiView: View {
//    let store: Store<Yabai.State, Yabai.Action>
//
//    var body: some View {
//        WithViewStore(store) { viewStore in
//            NavigationView {
//                SidebarView(store: store)
//                VStack {
//                    Text("Welcome Page")
//                        .font(.largeTitle)
//                        .foregroundColor(Color(NSColor.placeholderTextColor))
//                }
//            }
//            .onAppear { viewStore.send(.load) }
//            .sheet(isPresented: viewStore.binding(
//                    get: \.onboarding.isOnboaring,
//                    send: Yabai.Action.onboarding(.toggleIsOnboaring))
//            ) {
//                OnboardingView(store: store.scope(
//                            state: \.onboarding,
//                            action: Yabai.Action.onboarding))
//            }
//            .toolbar {
//                ToolbarItem {
//                    Button("Export Data") {
//                        viewStore.send(.exportConfigs)
//                    }
//                }
//                ToolbarItem {
//                    Button("Toggle OnboardingView") {
//                        viewStore.send(.onboarding(.toggleIsOnboaring))
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct YabaiView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView(store: Yabai.defaultStore)
//    }
//}
