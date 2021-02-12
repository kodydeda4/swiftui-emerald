//
//  Config.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/12/21.
//

import SwiftUI
import ComposableArchitecture

struct Config {
    struct State: Equatable {
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
        var activeWindowBorderColor : Color              = .clear
        var normalWindowBorderColor : Color              = .clear
        var insertFeedbackColor     : Color              = .clear
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
        case updateDebugOutput(Bool)
        case updateExternalBar(Config.State.ExternalBar)
        case updateMouseFollowsFocus(Bool)
        case updateFocusFollowsMouse(Config.State.FocusFollowsMouse)
        case updateWindowPlacement(Config.State.WindowPlacement)
        case updateWindowTopmost(Bool)
        case updateWindowShadow(Bool)
        case updateWindowOpacity(Bool)
        case updateWindowOpacityDuration(Float)
        case updateActiveWindowOpacity(Float)
        case updateNormalWindowOpacity(Float)
        case updateWindowBorder(Bool)
        case updateWindowBorderWidth(Int)
        case updateActiveWindowBorderColor(Color)
        case updateNormalWindowBorderColor(Color)
        case updateInsertFeedbackColor(Color)
        case updateSplitRatio(Float)
        case updateAutoBalance(Bool)
        case updateMouseModifier(Config.State.MouseModifier)
        case updateMouseAction1(Config.State.MouseAction)
        case updateMouseAction2(Config.State.MouseAction)
        case updateMouseDrop_action(Config.State.MouseDropAction)
    }
    
    struct Environment {
        // environment
    }
}

extension Config {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Reducer { state, action, environment in
            switch action {
            
            case let .updateDebugOutput(bool):
                state.debugOutput = bool
                return .none
                
            case let .updateExternalBar(externalBar):
                state.externalBar = externalBar
                return .none
                
            case let .updateMouseFollowsFocus(bool):
                state.mouseFollowsFocus = bool
                return .none
                
            case let .updateFocusFollowsMouse(focusFollowsMouse):
                state.focusFollowsMouse = focusFollowsMouse
                return .none
                
            case let .updateWindowPlacement(windowPlacement):
                state.windowPlacement = windowPlacement
                return .none
                
            case let .updateWindowTopmost(bool):
                state.windowTopmost = bool
                return .none
                
            case let .updateWindowShadow(bool):
                state.windowShadow = bool
                return .none
                
            case let .updateWindowOpacity(bool):
                state.windowOpacity = bool
                return .none
                
            case let .updateWindowOpacityDuration(float):
                state.windowOpacityDuration = float
                return .none
                
            case let .updateActiveWindowOpacity(float):
                state.activeWindowOpacity = float
                return .none
                
            case let .updateNormalWindowOpacity(float):
                state.normalWindowOpacity = float
                return .none
                
            case let .updateWindowBorder(bool):
                state.windowBorder = bool
                return .none
                
            case let .updateWindowBorderWidth(int):
                state.windowBorderWidth = int
                return .none
                
            case let .updateActiveWindowBorderColor(color):
                state.activeWindowBorderColor = color
                return .none
                
            case let .updateNormalWindowBorderColor(color):
                state.normalWindowBorderColor = color
                return .none
                
            case let .updateInsertFeedbackColor(color):
                state.insertFeedbackColor = color
                return .none
                
            case let .updateSplitRatio(float):
                state.splitRatio = float
                return .none
                
            case let .updateAutoBalance(bool):
                state.autoBalance = bool
                return .none
                
            case let .updateMouseModifier(mouseModifier):
                state.mouseModifier = mouseModifier
                return .none
                
            case let .updateMouseAction1(mouseAction):
                state.mouseAction1 = mouseAction
                return .none
                
            case let .updateMouseAction2(mouseAction):
                state.mouseAction2 = mouseAction
                return .none
                
            case let .updateMouseDrop_action(mouseDropAction):
                state.mouseDropAction = mouseDropAction
                return .none
                
            }
        }
    )
}

extension Config {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}

// MARK:- ConfigView

struct ConfigView: View {
    let store: Store<Config.State, Config.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView(store: Config.defaultStore)
    }
}
