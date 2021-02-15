//
//  Root.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/15/21.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct Root {
    struct State: Equatable {
        // state
        var onboarding = Onboarding.State()
    }
    
    enum Action: Equatable {
        // action
        case onboarding(Onboarding.Action)
        
    }
    
    struct Environment {
        // environment
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Onboarding.reducer.pullback(
            state: \.onboarding,
            action: /Root.Action.onboarding,
            environment: { _ in .init() }
        ),
        Reducer { state, action, environment in
            switch action {
            case let .onboarding(subAction):
                return .none
                
            }
        }
    )
}

extension Root {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}

// MARK:- RootView

struct RootView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {}
                //.onAppear { viewStore.send(.load) }
                .sheet(isPresented: viewStore.binding(
                        get: \.onboarding.isOnboaring,
                        send: Root.Action.onboarding(.toggleIsOnboaring))
                ) {
                    OnboardingView(store: store.scope(
                                    state: \.onboarding,
                                    action: Root.Action.onboarding))
                }
                .toolbar {
//                    ToolbarItem {
//                        Button("Export Data") {
//                            viewStore.send(.exportConfigs)
//                        }
//                    }
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
