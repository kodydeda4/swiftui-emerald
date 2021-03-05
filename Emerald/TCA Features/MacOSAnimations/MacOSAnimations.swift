//
//  Animations.swift
//  Emerald
//
//  Created by Kody Deda on 2/18/21.
//

import SwiftUI
import ComposableArchitecture

// Disable OSX Animations: https://apple.stackexchange.com/questions/14001/how-to-turn-off-all-animations-on-os-x

struct MacOSAnimations {
    struct State: Equatable, Codable {
        var allEnabled: Bool = true
        
    }
    enum Action: Equatable {
        case keyPath(BindingAction<MacOSAnimations.State>)
    }
}

extension MacOSAnimations {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        case .keyPath:
            return .none
        }
    }
    .binding(action: /Action.keyPath)
}

extension MacOSAnimations {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}
