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
                
                Button("Alert") {
                    viewStore.send(.alertButtonTapped)
                }
                .sheet(isPresented: .constant(true)) {
                    // sheet dismissed using Binding
                    // SheetView(isVisible: self.$sheetIsShowing, enteredText: self.$dialogResult)
                    
                    // sheet dismissed using Environment presentation mode
                    SheetView()
                }
                //                .alert(isPresented: .constant(true)) {
                //                    Alert(
                //                        title: Text("What's new in YabaiUI"),
                //                        message: Text("Lorem ipsum sum four three six nine"),
                //                        dismissButton: .default(Text("Continue")))
                //                }
                //.alert(store.scope(state: \.alert), dismiss: .alertDismissed)
                
            }
        }
    }
}

struct SheetView: View {
    //let store: Store<Onboarding.State, Onboarding.Action>

    @Environment(\.presentationMode) var presentationMode
    
    //@Binding var enteredText: String
    
    var body: some View {
        VStack {
            Button("Contine") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .frame(width: 300, height: 200)
        .padding()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(store: Onboarding.defaultStore)
    }
}
