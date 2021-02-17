//
//  SpaceSettings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/10/21.
//

import SwiftUI
import ComposableArchitecture

struct YabaiSettings {
    struct State: Equatable, Codable {
        var layout         : Layout  = .float
        var paddingTop     : Int     = 0
        var paddingBottom  : Int     = 0
        var paddingLeft    : Int     = 0
        var paddingRight   : Int     = 0
        var windowGap      : Int     = 0
        
        enum Layout: String, Codable, CaseIterable, Identifiable {
            var id: Layout { self }
            
            case float
            case bsp
            case stack
        }
    }
    enum Action: Equatable {
        case keyPath(BindingAction<YabaiSettings.State>)
    }
}

extension YabaiSettings {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        case .keyPath:
            return .none
        }
    }
    .binding(action: /Action.keyPath)
}

extension YabaiSettings {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}

extension YabaiSettings.State {
    var asConfig: String {
        [
            "yabai -m config layout \(layout)",
            "yabai -m config top_padding \(paddingTop)",
            "yabai -m config bottom_padding \(paddingBottom)",
            "yabai -m config left_padding \(paddingLeft)",
            "yabai -m config right_padding \(paddingRight)",
            "yabai -m config window_gap \(windowGap)",
        ]
        .joined(separator: "\n")
    }
}
