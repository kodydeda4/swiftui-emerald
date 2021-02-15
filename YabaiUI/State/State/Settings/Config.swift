//
//  Config.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/12/21.
//

import SwiftUI
import ComposableArchitecture

struct Config {
    struct State: Codable, Equatable {
        var debugOutput             : Bool               = false
        var externalBar             : ExternalBar        = .off
        var mouseFollowsFocus       : Bool               = false
        var focusFollowsMouse       : FocusFollowsMouse  = .off
        var windowPlacement         : WindowPlacement    = .firstChild
        var windowTopmost           : Bool               = false
        var windowShadow            : Bool               = false
        var windowOpacity           : Bool               = false
        var windowOpacityDuration   : Float              = 1
        var activeWindowOpacity     : Float              = 1
        var normalWindowOpacity     : Float              = 1
        var windowBorder            : Bool               = false
        var windowBorderWidth       : Int                = 0
        //        var activeWindowBorderColor : Color              = .clear
        //        var normalWindowBorderColor : Color              = .clear
        //        var insertFeedbackColor     : Color              = .clear
        var splitRatio              : Float              = 1
        var autoBalance             : Bool               = false
        var mouseModifier           : MouseModifier      = .cmd
        var mouseAction1            : MouseAction        = .move
        var mouseAction2            : MouseAction        = .move
        var mouseDropAction         : MouseDropAction    = .swap
        
        enum MouseModifier: String, Codable, CaseIterable, Identifiable {
            var id: MouseModifier { self }
            case cmd
            case alt
            case shift
            case ctrl
            case fn
        }
        
        enum MouseAction: String, Codable, CaseIterable, Identifiable  {
            var id: MouseAction { self }
            
            case move
            case resize
        }
        
        enum MouseDropAction: String, Codable, CaseIterable, Identifiable  {
            var id: MouseDropAction { self }
            
            case swap
            case stack
        }
        
        enum ExternalBar: String, Codable, CaseIterable, Identifiable  {
            var id: ExternalBar { self }
            
            case main
            case all
            case off
        }
        
        enum FocusFollowsMouse: String, Codable, CaseIterable, Identifiable  {
            var id: FocusFollowsMouse { self }
            
            case autoFocus
            case autoRaise
            case off
        }
        
        enum WindowPlacement: String, Codable, CaseIterable, Identifiable  {
            var id: WindowPlacement { self }
            
            case firstChild
            case secondChild
        }
    }
    
    enum Action: Equatable {
        case form(BindingAction<Config.State>)
    }
    
    struct Environment {
        // environment
    }
}

extension Config {
    static let reducer = Reducer<State, Action, Environment> {
        state, action, environment in
        switch action {
        case .form:
            return .none
        }
    }
    .binding(action: /Action.form)
}

extension Config {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}

