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
        case startYabai
        case stopYabai
        
        case restartSKHD
        case startSKHD
        case stopSKHD
    }
}

extension Homebrew {
    static let reducer = Reducer<State, Action, Void>.combine(
        Reducer { state, action, _ in
            switch action {
                    
            case .restartYabai:
                let result = AppleScript.execute("/usr/local/bin/brew services restart yabai")
                return Effect(value: .restartSKHD)
                
            case .startYabai:
                let result = AppleScript.execute("/usr/local/bin/brew services start yabai")
                return .none

            case .stopYabai:
                let result = AppleScript.execute("/usr/local/bin/brew services stop yabai")
                return .none
                
            case .restartSKHD:
                let result = AppleScript.execute("/usr/local/bin/brew services restart skhd")
                return .none

            case .startSKHD:
                let result = AppleScript.execute("/usr/local/bin/brew services start skhd")
                return .none

            case .stopSKHD:
                let result = AppleScript.execute("/usr/local/bin/brew services stop skhd")
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
