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
        var sipEnabled               : Bool              = true
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
        var windowOpacityDuration    : Float             = 100
        var activeWindowOpacity      : Float             = 100
        var normalWindowOpacity      : Float             = 100
        var windowBalance            : WindowBalance     = .normal
        var splitRatio               : Float             = 50
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
            
            var labelDescription: String {
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
            
            var labelDescription: String {
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
            
            var labelDescription: String {
                switch self {
                case .float : return "Normal"
                case .bsp   : return "Tiling"
                case .stack : return "Stacking"
                }
            }
            
            var desc: String {
                "foo"
            }
        }
        enum WindowBalance: String, Codable, CaseIterable, Identifiable {
            var id: WindowBalance { self }
            case normal
            case auto
            case custom
            
            var labelDescription: String {
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
        case toggleSIP
    }
}

extension Yabai {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        case .keyPath:
            return .none

        case .toggleSIP:
            state.sipEnabled.toggle()
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

