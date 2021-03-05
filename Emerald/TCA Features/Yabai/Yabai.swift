//
//  SpaceSettings.swift
//  Emerald
//
//  Created by Kody Deda on 2/10/21.
//

import SwiftUI
import ComposableArchitecture
import DynamicColor
import SwiftShell


struct Yabai {
    struct State: Equatable, Codable {
        var version                  = run("/usr/local/bin/yabai", "-v").stdout
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
        
        enum ExternalBar: String, Codable, CaseIterable, Identifiable {
            var id: ExternalBar { self }
            case main
            case all
            case off
        }
        enum WindowShadow: String, Codable, CaseIterable, Identifiable {
            var id: WindowShadow { self }
            case on
            case off
            case float
        }
        enum FocusFollowsMouse: String, Codable, CaseIterable, Identifiable {
            var id: FocusFollowsMouse { self }
            case autofocus
            case autoraise
            case off
        }
        enum WindowPlacement: String, Codable, CaseIterable, Identifiable {
            var id: WindowPlacement { self }
            case first_child
            case second_child
        }
        enum MouseModifier: String, Codable, CaseIterable, Identifiable {
            var id: MouseModifier { self }
            case cmd
            case alt
            case shift
            case ctrl
            case fn
        }
        enum MouseAction: String, Codable, CaseIterable, Identifiable {
            var id: MouseAction { self }
            case move
            case resize
        }
        enum MouseDropAction: String, Codable, CaseIterable, Identifiable {
            var id: MouseDropAction { self }
            case swap
            case stack
        }
        enum Layout: String, Codable, CaseIterable, Identifiable {
            var id: Layout { self }
            case float
            case bsp
            case stack
        }
    }
    
    enum Action: Equatable {
        case keyPath(BindingAction<Yabai.State>)
        case updateWindowShadows(Yabai.State.WindowShadow)
        case updateWindowPlacement(Yabai.State.WindowPlacement)
        case updateLayout(Yabai.State.Layout)
        case updateFocusFollowsMouse(Yabai.State.FocusFollowsMouse)
        case updateMouseAction1(Yabai.State.MouseAction)
        case updateMouseAction2(Yabai.State.MouseAction)
        case updateMouseDropAction(Yabai.State.MouseDropAction)
        case updateMouseModifier(Yabai.State.MouseModifier)
        case updateExternalBar(Yabai.State.ExternalBar)
        case updateActiveWindowBorderColor(Color)
        case updateNormalWindowBorderColor(Color)
        case updateInsertWindowBorderColor(Color)
    }
}

extension Yabai {
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
            
        case let .updateWindowShadows(windowShadow):
            state.windowShadow = windowShadow
            return .none
            
        case let .updateWindowPlacement(windowPlacement):
            state.windowPlacement = windowPlacement
            return .none
            
        case let .updateLayout(layout):
            state.layout = layout
            return .none
            
        case let .updateFocusFollowsMouse(focusFollowsMouse):
            state.focusFollowsMouse = focusFollowsMouse
            return .none
            
        case let .updateMouseAction1(mouseAction1):
            state.mouseAction1 = mouseAction1
            return .none
            
        case let .updateMouseAction2(mouseAction2):
            state.mouseAction2 = mouseAction2
            return .none
            
        case let .updateMouseDropAction(mouseDropAction):
            state.mouseDropAction = mouseDropAction
            return .none
            
        case let .updateMouseModifier(mouseModifier):
            state.mouseModifier = mouseModifier
            return .none
            
        case let .updateExternalBar(externalBar):
            state.externalBar = externalBar
            return .none
        }
    }
    .binding(action: /Action.keyPath)
}

extension Yabai {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}

