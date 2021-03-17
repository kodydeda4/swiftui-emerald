//
//  ResetAlertV2.swift
//  Emerald
//
//  Created by Kody Deda on 3/17/21.
//

//import SwiftUI
//import ComposableArchitecture
//
//struct ResetAlertV2 {
//    struct State: Equatable {
//        var alert: AlertState<ResetAlertV2.Action>?
//    }
//    
//    enum Action: Equatable {
//        case showAlert
//        case cancelTapped
//        case confirmTapped
//    }
//}
//
//extension ResetAlertV2 {
//    static let reducer = Reducer<State, Action, Void> {
//        state, action, environment in
//        switch action {
//        case .showAlert:
//            state.alert = .init(
//                title: TextState("Reset all settings?"),
//                message: TextState("You cannot undo this action."),
//                primaryButton: .destructive(TextState("Confirm"), send: .confirmTapped),
//                secondaryButton: .cancel()
//            )
//            return .none
//            
//        case .confirmTapped:
//            state.alert = nil
//            //
//            return .none
//            
//        case .cancelTapped:
//            state.alert = nil
//            return .none
//        }
//    }
//}
//
//extension ResetAlertV2 {
//    static let defaultStore = Store(
//        initialState: .init(),
//        reducer: reducer,
//        environment: ()
//    )
//}
//
//// MARK:- ResetAlertV2View
//
//struct ResetAlertV2View: View {
//    let store: Store<ResetAlertV2.State, ResetAlertV2.Action>
//    
//    var body: some View {
//        WithViewStore(store) { viewStore in
//            List {
//                Button("Alert") { viewStore.send(.showAlert) }
//                    .alert(store.scope(state: \.alert), dismiss: .cancelTapped)
//            }
//        }
//    }
//}
//
//struct ResetAlertV2View_Previews: PreviewProvider {
//    static var previews: some View {
//        ResetAlertV2View(store: ResetAlertV2.defaultStore)
//    }
//}
