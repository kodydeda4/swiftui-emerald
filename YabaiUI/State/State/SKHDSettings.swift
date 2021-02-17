//
//  SKHDSettings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/17/21.
//

import SwiftUI
import ComposableArchitecture

struct SKHDSettings {
    struct State: Equatable, Codable {
        var togglePadding : String = "lctrl + alt - g : yabai -m space --toggle padding; yabai -m space --toggle gap"
        var toggleSplit   : String = "lctrl + alt - x : yabai -m window --toggle split"
        
        var toggleBalance  = "lctrl + alt - 0 : yabai -m space --balance"
        var toggleStacking = "lctrl + alt - 1 : yabai -m space --layout stack"
        var toggleFloating = "lctrl + alt - 1 : yabai -m space --layout float"
        var toggleBSP      = "lctrl + alt - 2 : yabai -m space --layout bsp"
        
    }
    enum Action: Equatable {
        case keyPath(BindingAction<SKHDSettings.State>)
    }
}

extension SKHDSettings {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        case .keyPath:
            return .none
        }
    }
    .binding(action: /Action.keyPath)
}

extension SKHDSettings {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}

extension SKHDSettings.State {
    var asConfig: String {
        [
            "\(togglePadding)",
            "\(toggleSplit)",
            "\(toggleBalance)",
            "\(toggleStacking)",
            "\(toggleFloating)",
            "\(toggleBSP)",
        ]
        .joined(separator: "\n")
    }
}
