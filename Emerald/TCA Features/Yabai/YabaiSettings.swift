//
//  SpaceSettings.swift
//  Emerald
//
//  Created by Kody Deda on 2/10/21.
//

import SwiftUI
import ComposableArchitecture
import DynamicColor

struct YabaiSettings {
    struct State: Equatable, Codable {
        var debugOutput              : Bool              = false
        var externalBar              : ExternalBar       = .off
        var topPaddingExternalBar    : Int               = 0
        var bottomPaddingExternalBar : Int               = 0
        var mouseFollowsFocus        : Bool              = false
        var focusFollowsMouse        : FocusFollowsMouse = .off
        var windowPlacement          : WindowPlacement   = .first_child
        var windowTopmost            : Bool              = false
        var windowShadow             : WindowShadow      = .on
        var windowOpacity            : Bool              = false
        var windowOpacityDuration    : Float             = 1
        var activeWindowOpacity      : Float             = 1
        var normalWindowOpacity      : Float             = 1
        var windowBorder             : Bool              = false
        var windowBorderWidth        : Int               = 0
        var activeWindowBorderColor  : CodableColor      = .init(color: .green)
        var normalWindowBorderColor  : CodableColor      = .init(color: .red)
        var insertWindowBorderColor  : CodableColor      = .init(color: .purple)
        var splitRatio               : Float             = 0.5
        var autoBalance              : Bool              = false
        var mouseModifier            : MouseModifier     = .fn
        var mouseAction1             : MouseAction       = .move
        var mouseAction2             : MouseAction       = .resize
        var mouseDropAction          : MouseDropAction   = .swap
        var layout                   : Layout            = .float
        var paddingTop               : Int               = 0
        var paddingBottom            : Int               = 0
        var paddingLeft              : Int               = 0
        var paddingRight             : Int               = 0
        var windowGap                : Int               = 0
    }
    enum Action: Equatable {
        case keyPath(BindingAction<YabaiSettings.State>)
        case updateActiveWindowBorderColor(Color)
        case updateNormalWindowBorderColor(Color)
        case updateInsertWindowBorderColor(Color)
    }
}

extension YabaiSettings {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        case .keyPath:
            return .none
            
        case let .updateActiveWindowBorderColor(color):
            state.activeWindowBorderColor = CodableColor(color: color)
            return .none

        case let .updateNormalWindowBorderColor(color):
            state.normalWindowBorderColor = CodableColor(color: color)
            return .none

        case let .updateInsertWindowBorderColor(color):
            state.insertWindowBorderColor = CodableColor(color: color)
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

