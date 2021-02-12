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
        var isDismissed = false
    }
    
    enum Action: Equatable {
        case toggleDismissed
    }
    
    struct Environment {
        // environment
    }
}

extension Onboarding {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Reducer { state, action, environment in
            switch action {
            
            case .toggleDismissed:
                state.isDismissed.toggle()
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


struct VStackOfTextViews: View {
    
    var body: some View {
        VStack {
            Group {
                Text("largeTitle")
                    .font(.largeTitle)
                
                Text("title")
                    .font(.title)
                
                Text("title2")
                    .font(.title2)
                
                Text("title3")
                    .font(.title3)
            }
            
            Group {
                Text("subheadline")
                    .font(.subheadline)
                
                Text("headline")
                    .font(.headline)
            }
            
            Group {
                Text("body")
                    .font(.body)
                
                Text("caption")
                    .font(.caption)
                
                Text("caption2")
                    .font(.caption2)
                
                Text("footnote")
                    .font(.footnote)
                
                Text("callout")
                    .font(.callout)
                
            }
        }
    }
}

struct VStackOfTextViews_Previews: PreviewProvider {
    static var previews: some View {
        VStackOfTextViews()
    }
}


// MARK:- OnboardingView

struct OnboardingView: View {
    let store: Store<Onboarding.State, Onboarding.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Image("iconLogo")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text("Welcome to YabaiUI")
                    .font(.largeTitle)
                
                
                Button("Contine") {
                    viewStore.send(.toggleDismissed)
                }
            }
            .padding()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(store: Onboarding.defaultStore)
    }
}
