//
//  Onboarding.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

//MARK:- Onboarding

struct Onboarding {
    struct State: Equatable {
        var alert: AlertState<Onboarding.Action>?
        var count = 0
    }
    
    enum Action: Equatable {
        case alertButtonTapped
        case alertCancelTapped
        case alertDismissed
        case decrementButtonTapped
        case incrementButtonTapped
    }
    
    struct Environment {
        // environment
    }
}

extension Onboarding {
    static let reducer = Reducer<State, Action, Environment>.combine(
        // pullbacks
        
        Reducer { state, action, environment in
            // mutations
            switch action {
            
            case .alertButtonTapped:
                state.alert = .init(
                    title: .init("Alert!"),
                    message: .init("This is an alert"),
                    primaryButton: .cancel(),
                    secondaryButton: .default(.init("Increment"), send: .incrementButtonTapped)
                )
                return .none
                
            case .alertCancelTapped:
                return .none
                
            case .alertDismissed:
                state.alert = nil
                return .none
                
            case .decrementButtonTapped:
                state.alert = .init(title: .init("Decremented!"))
                state.count -= 1
                return .none
                
            case .incrementButtonTapped:
                state.alert = .init(title: .init("Incremented!"))
                state.count += 1
                return .none
            }
        }
    )
}

extension Onboarding {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}

// MARK:- OnboardingView
struct OnboardingView: View {
    let store: Store<Onboarding.State, Onboarding.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Form {
                Text("Count: \(viewStore.count)")

                Button("Alert") { viewStore.send(.alertButtonTapped) }
                  .alert(store.scope(state: \.alert),
                    dismiss: .alertDismissed
                  )
              }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(store: Onboarding.defaultStore)
    }
}
