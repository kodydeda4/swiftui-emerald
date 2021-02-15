//
//  SpaceSettings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/10/21.
//

import SwiftUI
import ComposableArchitecture

struct SpaceSettings {
    struct State: Equatable, Codable {
        var layout         : Layout  = .float
        var paddingTop     : Int     = 0
        var paddingBottom  : Int     = 0
        var paddingLeft    : Int     = 0
        var paddingRight   : Int     = 0
        var windowGap      : Int     = 0
        
        enum Layout: String, Codable, CaseIterable, Identifiable {
            case bsp
            case stack
            case float
            
            var id: Layout { self }
        }
    }
    enum Action: Equatable {
        case keyPath(BindingAction<SpaceSettings.State>)
    }
}

extension SpaceSettings {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        case .keyPath:
            return .none
        }
    }
    .binding(action: /Action.keyPath)
}

extension SpaceSettings {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}


//case let .updateLayout(layout):
//state.layout = layout
//switch layout {
//case .float:
//    let _ = AppleScript.yabaiSetFloating.execute()
//case .bsp:
//    let _ = AppleScript.yabaiSetBSP.execute()
//case .stack:
//    print()
//}
//return .none
