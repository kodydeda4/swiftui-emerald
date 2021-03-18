//
//  Animations.swift
//  Emerald
//
//  Created by Kody Deda on 2/18/21.
//

import SwiftUI
import ComposableArchitecture

// Modify macOS Animations through a Shell Script.
//      ~ Disable OSX Animations:
//        https://apple.stackexchange.com/questions/14001/how-to-turn-off-all-animations-on-os-x

struct MacOSAnimations {
    struct State: Equatable, Codable {
        var stateURL    = URL(fileURLWithPath: "AnimationsState.json",  relativeTo: .HomeDirectory)
        var shellScriptURL = URL(fileURLWithPath: ".macOSAnimationsRC.sh", relativeTo: .HomeDirectory)
        
        var enabled     = true
    }
    enum Action: Equatable {
        case toggleEnabled
        case executeShellScript
    }
}

extension MacOSAnimations {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {

        case .toggleEnabled:
            state.enabled.toggle()
            return.none

        case .executeShellScript:
            let _ = AppleScript.execute("sudo chmod +x \(state.shellScriptURL.relativePath)")
            let _ = AppleScript.execute("\(state.shellScriptURL.relativePath)")
            return .none
        }
    }
}

extension MacOSAnimations {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}
 
