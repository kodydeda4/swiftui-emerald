//
//  SpaceSettings.swift
//  Emerald
//
//  Created by Kody Deda on 2/10/21.
//

import SwiftUI
import ComposableArchitecture

/*
 TODO:
  - variable names must be updated to properly reflect .yabairc file
  - debugOutput seems to capture output when started
 
 What is System Integrity Protection and why does it need to be disabled?
 https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection
 
 **** For BigSur you have to follow extra steps to automatically load SA.
 https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#macos-big-sur---automatically-load-scripting-addition-on-startup
 
 - focus/create/destroy space without animation
 - move space (and its windows) left, right or to another display
 - remove window shadows
 - enable window transparency
 - control window layers (make windows appear topmost)
 - sticky windows (make windows appear on all spaces)
 - move window by clicking anywhere in its frame
 - toggle picture-in-picture for any given window
 - border for focused and inactive windows

 
 Notes:
 - Apply Changes is slow.  Maybe because it's reading/writing all at once?
 - Textfields should be limited to 0.0 - 1.0 for
 WindowOpacityDuration,
 ActiveWindowOpacity,
 NormalWindowOpacity
 
 √ = Tested & Works
 E = Tested & Doesn't work/improperly implemented
 
    [E] debugOutput
 
    [√] externalBar
    [√] topPaddingExternalBar
    [√] bottomPaddingExternalBar
 
    [√] mouseFollowsFocus
    [√] focusFollowsMouse
    [√] windowPlacement
 
    [√] windowTopmost
    [√] windowShadow
    [√] windowOpacity
    [√] windowOpacityDuration
    [√] activeWindowOpacity
    [√] normalWindowOpacity
 
    [√] windowBorder
    [√] windowBorderWidth
    [√] activeWindowBorderColor
    [√] normalWindowBorderColor
 
    [√] splitRatio
    [√] autoBalance
    [√] mouseModifier
    [√] mouseAction1
    [√] mouseAction2
    [√] mouseDropAction
 
    [√] layout
    [√] paddingTop
    [√] paddingBottom
    [√] paddingLeft
    [√] paddingRight
    [√] windowGap
  
 */

struct YabaiSettings {
    struct State: Equatable, Codable {
        var debugOutput              : Bool              = false
        var externalBar              : ExternalBar       = .off
        var topPaddingExternalBar    : Int               = 0
        var bottomPaddingExternalBar : Int               = 0
        var mouseFollowsFocus        : Bool              = false
        var focusFollowsMouse        : FocusFollowsMouse = .off
        var windowPlacement          : WindowPlacement   = .first_child
        var windowTopmost            : Bool              = false // floating windows are always on top
        var windowShadow             : WindowShadow      = .on
        var windowOpacity            : Bool              = false
        var windowOpacityDuration    : Float             = 1
        var activeWindowOpacity      : Float             = 1
        var normalWindowOpacity      : Float             = 1
        var windowBorder             : Bool              = false
        var windowBorderWidth        : Int               = 0
        var activeWindowBorderColor  : String            = "COLOR" // Color = .clear
        var normalWindowBorderColor  : String            = "COLOR" // Color = .clear
        var insertFeedbackColor      : String            = "COLOR" // Color = .clear
        var splitRatio               : Float             = 0.5
        var autoBalance              : Bool              = false // automatically split_ratios so that all windows always occupy the same space independent of how deeply nested they are in the window tree
        var mouseModifier            : MouseModifier     = .cmd //Keyboard modifier used for moving and resizing windows.
        var mouseAction1             : MouseAction       = .move // mouseModifier + leftClick performs action
        var mouseAction2             : MouseAction       = .resize // mouseModifier + rightClick performs action
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
            
            var rawValue: String {
                switch self {
                case .on: return "on"
                case .off: return "off"
                case .float: return "floating-only"
                }
            }
            
            var uiDescription: String {
                switch self {
                case .on: return "enable window shadows."
                case .off: return "disable window shadows."
                case .float: return "only floating windows will have a shadow."
                }
            }
        }

        enum FocusFollowsMouse: String, Codable, CaseIterable, Identifiable {
            var id: FocusFollowsMouse { self }
            case autofocus
            case autoraise
            case off
            
            var rawValue: String {
                switch self {
                case .autofocus: return "auto-focus"
                case .autoraise: return "auto-raise"
                case .off: return "off"
                }
            }
            
            var uiDescription: String {
                switch self {
                case .autofocus: return "Window gets focused"
                case .autoraise: return "Window gets focused & raised, as if it was clicked on"
                case .off: return ""
                }
            }
        }
        
        enum WindowPlacement: String, Codable, CaseIterable, Identifiable {
            var id: WindowPlacement { self }
            case first_child
            case second_child
            
            var rawValue: String {
                switch self {
                case .first_child: return "first-child"
                case .second_child: return "second-child"
                }
            }
            
            var uiDescription: String {
                switch self {
                case .first_child: return "New window spawns to the left if vertical split, or top if horizontal split"
                case .second_child: return "New window spawns to the right if vertical split, or bottom if horizontal split"
                }
            }
        }
        
        enum MouseModifier: String, Codable, CaseIterable, Identifiable {
            var id: MouseModifier { self }
            case cmd
            case alt
            case shift
            case ctrl
            case fn
            case secondChild
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
        let divStr = "#========================================================="
        return
        [
            "#   ██╗   ██╗ █████╗ ██████╗  █████╗ ██╗",
            "#   ╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗██║",
            "#    ╚████╔╝ ███████║██████╔╝███████║██║",
            "#     ╚██╔╝  ██╔══██║██╔══██╗██╔══██║██║",
            "#      ██║   ██║  ██║██████╔╝██║  ██║██║",
            "#      ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝",
            "#",
            "",
            divStr,
            "# TEMPORARILY HARDCODED",
            divStr,
            "yabai -m rule --add label=\"System Preferences\" app=\"^System Preferences$\" manage=off",
            "",
            divStr,
            "# General",
            divStr,
            "yabai -m config debug_output \(debugOutput == true ? "on" : "off")",
            "yabai -m config external_bar \(externalBar):\(topPaddingExternalBar):\(bottomPaddingExternalBar)",
            "yabai -m config mouse_follows_focus \(mouseFollowsFocus == true ? "on" : "off")",
            "yabai -m config focus_follows_mouse \(focusFollowsMouse)",
            "",
            divStr,
            "# Window Misc",
            divStr,
            "yabai -m config window_placement \(windowPlacement)",
            "yabai -m config window_shadow \(windowShadow)",
            "",
            divStr,
            "# Window Opacity",
            divStr,
            "yabai -m config window_opacity \(windowOpacity == true ? "on" : "off")",
            "yabai -m config window_opacity_duration \(windowOpacityDuration)",
            "yabai -m config active_window_opacity \(activeWindowOpacity)",
            "yabai -m config normal_window_opacity \(normalWindowOpacity)",
            "",
            divStr,
            "# Window Borders",
            divStr,
            "yabai -m config window_border \(windowBorder == true ? "on" : "off")",
            "yabai -m config window_border_width \(windowBorderWidth)",
            //MARK:- Hardcoded
            "yabai -m config active_window_border_color \"0xff99cc99\"", //colorString == 0xff + HEXVALUE
            "yabai -m config normal_window_border_color \"0xffe09ba4\"",
            "yabai -m config insert_window_border_color \"0xffbf7fbf\"",
            //MARK:- Hardcoded
            "",
            divStr,
            "# Misc",
            divStr,
            "yabai -m config split_ratio \(splitRatio)",
            "yabai -m config auto_balance \(autoBalance == true ? "on" : "off")",
            "",
            divStr,
            "# Mouse Actions",
            divStr,
            "yabai -m config mouse_modifier \(mouseModifier)",
            "yabai -m config mouse_action1 \(mouseAction1)",
            "yabai -m config mouse_action2 \(mouseAction2)",
            "yabai -m config mouse_drop_action \(mouseDropAction)",
            "",
            divStr,
            "# Space Settings",
            divStr,
            "yabai -m config layout \(layout)",
            "yabai -m config top_padding \(paddingTop)",
            "yabai -m config bottom_padding \(paddingBottom)",
            "yabai -m config left_padding \(paddingLeft)",
            "yabai -m config right_padding \(paddingRight)",
            "yabai -m config window_gap \(windowGap)",
            "",
            divStr,
            "# Load Scripting Addition",
            divStr,
            "sudo yabai --load-sa",
            "yabai -m signal --add event=dock_did_restart action=\"sudo yabai --load-sa\"",
            divStr,
            "",
            "# Scripting Addition Options",
            "yabai -m config window_topmost \(windowTopmost == true ? "on" : "off")",
            
            

        ]
        .joined(separator: "\n")
    }
}
