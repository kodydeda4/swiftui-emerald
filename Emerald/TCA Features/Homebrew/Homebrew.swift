//
//  Homebrew.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import ComposableArchitecture
import SwiftShell

struct Homebrew {
    struct State: Equatable {
        var version = run("/usr/local/bin/brew", "-v").stdout
    }
    
    enum Action: Equatable {
        // action
    }
}

extension Homebrew {
    static let reducer = Reducer<State, Action, Void>.combine(
//        Reducer { state, action, _ in
//            switch action {
//            
//            }
//        }
    )
}

extension Homebrew {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}
