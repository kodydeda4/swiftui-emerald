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
        
        
        var yabaiRunning = true
        var skhdRunning = true
        var macOSAnimationsRunning = true
    }
    
    enum Action: Equatable {
        case restartYabai
//        case restartYabaiLaunchCTL
        case toggleYabai
        case restartSKHD
        case toggleSKHD
    }
}

extension Homebrew {
    static let reducer = Reducer<State, Action, Void>.combine(
        Reducer { state, action, _ in
            switch action {
                    
            case .restartYabai:
                let result = AppleScript.execute("/usr/local/bin/brew services restart yabai")
                return .none
                
            //            case .restartYabaiLaunchCTL:
            //                let result = AppleScript.execute(
            //                    "/bin/launchctl kickstart -k \\\"gui/$UID/homebrew.mxcl.yabai\\\""
            //                // do shell script "/bin/launchctl kickstart -k \"gui/$UID/homebrew.mxcl.yabai\""
            //                )
            //                return .none
                
            case .toggleYabai:
                switch state.yabaiRunning {
                case true : let result = AppleScript.execute("/usr/local/bin/brew services stop yabai")
                case false: let result = AppleScript.execute("/usr/local/bin/brew services start yabai")
                }
                state.yabaiRunning.toggle()
                return .none

            case .toggleSKHD:
                switch state.skhdRunning {
                case true : let _ = AppleScript.execute("/usr/local/bin/brew services stop  skhd")
                case false: let _ = AppleScript.execute("/usr/local/bin/brew services start skhd")
                }
                state.skhdRunning.toggle()
                return .none

            case .restartSKHD:
                let result = AppleScript.execute("/usr/local/bin/brew services restart skhd")
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
