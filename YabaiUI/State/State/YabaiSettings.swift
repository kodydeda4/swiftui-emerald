//
//  SpaceSettings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/10/21.
//

import SwiftUI
import ComposableArchitecture


//struct YabaiConfig: Equatable, Codable {
//    var layout         : String  = "yabai -m config layout floating"
//    var paddingTop     : String  = "yabai -m config top_padding    0"
//    var paddingBottom  : String  = "yabai -m config bottom_padding 0"
//    var paddingLeft    : String  = "yabai -m config left_padding   0"
//    var paddingRight   : String  = "yabai -m config right_padding  0"
//    var windowGap      : String  = "yabai -m config window_gap     0"
//
//    var description: String {
//        [layout,
//         paddingTop,
//         paddingBottom,
//         paddingRight,
//         paddingLeft,
//         windowGap
//        ]
//        .map { $0 + "\n"}
//        .joined()
//    }
//}

struct YabaiSettings {
    struct State: Equatable, Codable {
        var layout         : Layout  = .float
        var paddingTop     : Int     = 0
        var paddingBottom  : Int     = 0
        var paddingLeft    : Int     = 0
        var paddingRight   : Int     = 0
        var windowGap      : Int     = 0
        
        enum Layout: String, Codable, CaseIterable, Identifiable {
            case float
            case bsp
            case stack
            
            var id: Layout { self }
        }
        
        private enum CodingKeys : String, CodingKey {
            case layout = "yabai -m config layout"
              
         }
    }
    enum Action: Equatable {
        case updateLayout(YabaiSettings.State.Layout)
        case updatePaddingTop(Int)
        case updatePaddingLeft(Int)
        case updatePaddingRight(Int)
        case updatePaddingBottom(Int)
        case updateWindowGap(Int)
    }
}

extension YabaiSettings {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        
        case let .updateLayout(layout):
            state.layout = layout
//            switch layout {
//            case .float:
//                let _ = AppleScript.yabaiSetFloating.execute()
//            case .bsp:
//                let _ = AppleScript.yabaiSetBSP.execute()
//            case .stack:
//                let _ = AppleScript.yabaiSetStacking.execute()
//            }
            //state.configFile.layout = "yabai -m config layout \(layout)"
            return .none
                        
        case let .updatePaddingTop(int):
            state.paddingTop = int
            //state.configFile.paddingTop = "yabai -m top_padding \(int)"
            return .none
            
        case let .updatePaddingBottom(int):
            state.paddingBottom = int
            //state.configFile.paddingBottom = "yabai -m bottom_padding \(int)"
            return .none
            
        case let .updatePaddingLeft(int):
            state.paddingLeft = int
            //state.configFile.paddingLeft = "yabai -m left_padding \(int)"
            return .none
            
        case let .updatePaddingRight(int):
            state.paddingRight = int
            //state.configFile.paddingRight = "yabai -m right_padding \(int)"
            return .none
            
        case let .updateWindowGap(int):
            state.windowGap = int
            //state.configFile.windowGap = "yabai -m window_gap \(int)"
            return .none
        }
    }
}

extension YabaiSettings {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}
