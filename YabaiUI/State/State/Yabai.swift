//
//  Yabai.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/10/21.
//

import SwiftUI
import ComposableArchitecture

struct Yabai {
    struct State: Equatable, Codable {
        var layout: Layout = .float
        var paddingTop: Int = 0
        var paddingBottom: Int = 0
        var paddingLeft: Int = 0
        var paddingRight: Int = 0
        var windowGap: Int = 0
        
        enum Layout: String, Codable, CaseIterable, Identifiable {
            case bsp
            case stack
            case float
            
            var id: Layout { self }
        }
    }
    
    enum Action: Equatable {
        case updateLayout(State.Layout)
        case updatePaddingTop(Int)
        case updatePaddingBottom(Int)
        case updatePaddingLeft(Int)
        case updatePaddingRight(Int)
        case updateWindowGap(Int)
    }
    
    struct Environment {
        // environment
    }
}

extension Yabai {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Reducer { state, action, environment in
            switch action {
            
            case let .updateLayout(layout):
                state.layout = layout
                switch layout {
                case .float:
                    let _ = AppleScript.yabaiSetFloating.execute()
                case .bsp:
                    let _ = AppleScript.yabaiSetBSP.execute()
                case .stack:
                    print()
                }
                return .none
                
            case let .updatePaddingTop(int):
                state.paddingTop = int
                return .none
                
            case let .updatePaddingBottom(int):
                state.paddingBottom = int
                return .none
                
            case let .updatePaddingLeft(int):
                state.paddingLeft = int
                return .none
                
            case let .updatePaddingRight(int):
                state.paddingRight = int
                return .none
                
            case let .updateWindowGap(int):
                state.windowGap = int
                return .none
            }
        }
    )
}

extension Yabai {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}

