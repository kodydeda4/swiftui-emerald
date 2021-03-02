//
//  SpaceSettings.swift
//  Emerald
//
//  Created by Kody Deda on 2/10/21.
//

import SwiftUI
import ComposableArchitecture

/*
 Notes:
 - Apply Changes is slow.  Maybe because it's reading/writing all at once?

    [!] debugOutput
 
    [X] externalBar
    [X] topPaddingExternalBar
    [X] bottomPaddingExternalBar
 
    [ ] mouseFollowsFocus
    [ ] focusFollowsMouse
    [ ] windowPlacement
    [ ] windowTopmost
    [ ] windowShadow
    [ ] windowOpacity
    [ ] windowOpacityDuration
    [ ] activeWindowOpacity
    [ ] normalWindowOpacity
    [ ] windowBorder
    [ ] windowBorderWidth
    [ ] activeWindowBorderColor
    [ ] normalWindowBorderColor
    [ ] insertFeedbackColor
    [ ] splitRatio
    [ ] autoBalance
    [ ] mouseModifier
    [ ] mouseAction1
    [ ] mouseAction2
    [ ] mouseDropAction
 
    [√] layout
    [√] paddingTop
    [√] paddingBottom
    [√] paddingLeft
    [√] paddingRight
    [√] windowGap
  
 */


/*
 
TODO:
 - variable names must be updated to properly reflect .yabairc file
 - debugOutput seems to capture output when started
 */
struct YabaiSettings {
    struct State: Equatable, Codable {
        var debugOutput              : Bool              = false
        var externalBar              : ExternalBar       = .off
        var topPaddingExternalBar    : Int               = 0
        var bottomPaddingExternalBar : Int               = 0
        var mouseFollowsFocus        : Bool              = false
        var focusFollowsMouse        : FocusFollowsMouse = .off
        var windowPlacement          : WindowPlacement   = .firstChild
        var windowTopmost            : Bool              = false
        var windowShadow             : Float             = 1
        var windowOpacity            : Bool              = true
        var windowOpacityDuration    : Float             = 1
        var activeWindowOpacity      : Float             = 1
        var normalWindowOpacity      : Float             = 1
        var windowBorder             : Bool              = false
        var windowBorderWidth        : Int               = 0
        var activeWindowBorderColor  : String            = "COLOR" // Color = .clear
        var normalWindowBorderColor  : String            = "COLOR" // Color = .clear
        var insertFeedbackColor      : String            = "COLOR" // Color = .clear
        var splitRatio               : Float             = 1
        var autoBalance              : Bool              = false
        var mouseModifier            : MouseModifier     = .cmd
        var mouseAction1             : MouseAction       = .move
        var mouseAction2             : MouseAction       = .move
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

        enum FocusFollowsMouse: String, Codable, CaseIterable, Identifiable {
            var id: FocusFollowsMouse { self }
            case autofocus
            case autoraise
            case off
        }
        
        enum WindowPlacement: String, Codable, CaseIterable, Identifiable {
            var id: WindowPlacement { self }
            case firstChild
            case secondChild
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
            "# Global",
            divStr,
            "yabai -m config debug_output \(debugOutput == true ? "on" : "off")",
            "yabai -m config external_bar \(externalBar):\(topPaddingExternalBar):\(bottomPaddingExternalBar)",
            "yabai -m config mouse_follows_focus \(mouseFollowsFocus == true ? "on" : "off")",
            "yabai -m config focus_follows_mouse \(focusFollowsMouse)",
            "",
//            divStr,
//            "# Window Misc",
//            divStr,
//            "yabai -m config windowPlacement \(windowPlacement)",
//            "yabai -m config windowTopmost \(windowTopmost == true ? "on" : "off")",
//            "yabai -m config windowShadow \(windowShadow)",
//            "",
//            divStr,
//            "# Window Opacity",
//            divStr,
//            "yabai -m config windowOpacity \(windowOpacity == true ? "on" : "off")",
//            "yabai -m config windowOpacityDuration \(windowOpacityDuration)",
//            "yabai -m config activeWindowOpacity \(activeWindowOpacity)",
//            "yabai -m config normalWindowOpacity \(normalWindowOpacity)",
//            "",
//            divStr,
//            "# Window Borders",
//            divStr,
//            "yabai -m config windowBorder \(windowBorder == true ? "on" : "off")",
//            "yabai -m config windowBorderWidth \(windowBorderWidth)",
//            "yabai -m config activeWindowBorderColor \(activeWindowBorderColor)",
//            "yabai -m config normalWindowBorderColor \(normalWindowBorderColor)",
//            "",
//            divStr,
//            "# Misc",
//            divStr,
//            "yabai -m config insertFeedbackColor \(insertFeedbackColor)",
//            "yabai -m config splitRatio \(splitRatio)",
//            "yabai -m config autoBalance \(autoBalance == true ? "on" : "off")",
//            "",
//            divStr,
//            "# Mouse Actions",
//            divStr,
//            "yabai -m config mouseModifier \(mouseModifier)",
//            "yabai -m config mouseAction1 \(mouseAction1)",
//            "yabai -m config mouseAction2 \(mouseAction2)",
//            "yabai -m config mouseDropAction \(mouseDropAction)",
//            "",
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
        ]
        .joined(separator: "\n")
    }
}
