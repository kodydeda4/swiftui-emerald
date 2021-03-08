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
        var stateURL                 = URL(fileURLWithPath: "YabaiState.json", relativeTo: .HomeDirectory)
        var configURL                = URL(fileURLWithPath: ".yabairc", relativeTo: .HomeDirectory)
        var version                  = run("/usr/local/bin/yabai", "-v").stdout
        var debugOutput              : Bool              = false
        var externalBar              : ExternalBar       = .all
        var externalBarEnabled       : Bool              = false
        var externalBarPaddingTop    : Int               = 0
        var externalBarPaddingBottom : Int               = 0
        var mouseFollowsFocus        : Bool              = false
        var focusFollowsMouse        : FocusFollowsMouse = .autofocus
        var focusFollowsMouseEnabled : Bool              = false
        var windowPlacement          : WindowPlacement   = .first_child
        var windowTopmost            : Bool              = false
        
        var disableShadows           : Bool              = false
        var windowShadow             : WindowShadow      = .off
        var windowOpacity            : Bool              = false
        
        var windowOpacityDuration    : Int               = 100
        var activeWindowOpacity      : Int               = 100
        var normalWindowOpacity      : Int               = 100
        
        var windowBalance            : WindowBalance     = .normal
        var splitRatio               : Int               = 50
        var autoBalance              : Bool              = false

        
        var windowBorder             : Bool              = false
        var windowBorderWidth        : Int               = 0
        var activeWindowBorderColor  : CodableColor      = .init(color: .green)
        var normalWindowBorderColor  : CodableColor      = .init(color: .red)
        var insertWindowBorderColor  : CodableColor      = .init(color: .purple)
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
            //case off
            case all
            case main
        }
        enum WindowShadow: String, Codable, CaseIterable, Identifiable {
            var id: WindowShadow { self }
            //case on
            case off
            case float
            
            var uiDescription: String {
                switch self {
                //case .on    : return "On"
                case .off   : return "All"
                case .float : return "Non-Floating"
                }
            }
        }
        enum FocusFollowsMouse: String, Codable, CaseIterable, Identifiable {
            var id: FocusFollowsMouse { self }
            //case off
            case autofocus
            case autoraise
        }
        enum WindowPlacement: String, Codable, CaseIterable, Identifiable {
            var id: WindowPlacement { self }
            case first_child
            case second_child
            
            var uiDescription: String {
                switch self {
                case .first_child  : return "First Child"
                case .second_child : return "Second Child"
                }
            }
        }
        enum MouseModifier: String, Codable, CaseIterable, Identifiable {
            var id: MouseModifier { self }
            case fn
            case shift
            case ctrl
            case alt
            case cmd
            
            var uiDescription: String {
                switch self {
                case .fn    : return "Fn"
                case .shift : return "⇧ Shift"
                case .ctrl  : return "⌃ Control"
                case .alt   : return "⌥ Option"
                case .cmd   : return "⌘ Command"
                }
            }
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
            
            var uiDescription: String {
                switch self {
                case .float : return "Normal"
                case .bsp   : return "Tiling"
                case .stack : return "Stacking"
                }
            }
        }
        enum WindowBalance: String, Codable, CaseIterable, Identifiable {
            var id: WindowBalance { self }
            case normal
            case auto
            case custom
            
            var uiDescription: String {
                switch self {
                case .normal : return "Normal"
                case .auto   : return "Auto"
                case .custom : return "Custom"
                }
            }
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
        case updateWindowOpacityDuration(Int)
        case updatetActiveWindowOpacity(Int)
        case updateNormalWindowOpacity(Int)
        case updateSplitRatio(Int)
        case toggleExternalBarIsDisabled
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
            
        case let .updateWindowOpacityDuration(windowOpacityDuration):
            state.windowOpacityDuration = windowOpacityDuration
            return .none
            
        case let .updatetActiveWindowOpacity(activeWindowOpacity):
            state.activeWindowOpacity = activeWindowOpacity
            return .none
            
        case let .updateNormalWindowOpacity(normalWindowOpacity):
            state.normalWindowOpacity = normalWindowOpacity
            return .none
            
        case let .updateSplitRatio(splitRatio):
            state.splitRatio = splitRatio
            return .none
            
        case .toggleExternalBarIsDisabled:
            state.externalBarEnabled.toggle()
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

