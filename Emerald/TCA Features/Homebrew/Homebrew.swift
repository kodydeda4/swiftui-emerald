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
        case restartYabai
        case stopYabai
        case startYabai
    }
}

extension Homebrew {
    static let reducer = Reducer<State, Action, Void>.combine(
        Reducer { state, action, _ in
            switch action {
            case .restartYabai:
                let result = AppleScript.execute("/usr/local/bin/brew services restart Yabai")
                return .none
                
            case .stopYabai:
                let result = AppleScript.execute("/usr/local/bin/brew services stop Yabai")
                return .none
                
            case .startYabai:
                let result = AppleScript.execute("/usr/local/bin/brew services start Yabai")
                return .none

            }
        }
    )
}

extension Homebrew {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}
