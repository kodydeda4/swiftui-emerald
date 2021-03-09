//
//  YabaiConfigFile.swift
//  Emerald
//
//  Created by Kody Deda on 3/3/21.
//

import Foundation
import SwiftShell

extension Yabai.State {
    var asConfig: String {
"""
#
#
#   ██╗   ██╗ █████╗ ██████╗  █████╗ ██╗
#   ╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗██║
#    ╚████╔╝ ███████║██████╔╝███████║██║
#     ╚██╔╝  ██╔══██║██╔══██╗██╔══██║██║
#      ██║   ██║  ██║██████╔╝██║  ██║██║
#      ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝
#
#   ~/\(configURL.relativePath)
#   \(version)
#

#=========================================================================================
# Debug
#=========================================================================================
yabai -m config debug_output \(debugOutput == true ? "on" : "off")

#=========================================================================================
# Space
#=========================================================================================
# Layout
yabai -m config layout \(layout)

# Padding
yabai -m config top_padding \(paddingTop)
yabai -m config bottom_padding \(paddingBottom)
yabai -m config left_padding \(paddingLeft)
yabai -m config right_padding \(paddingRight)
yabai -m config window_gap \(windowGap)

#=========================================================================================
# Window
#=========================================================================================
# Shadows
yabai -m config window_shadow \(!disableShadows ? "on" : windowShadow.rawValue)

# Opacity Effects
yabai -m config window_opacity \(windowOpacity == true ? "on" : "off")
yabai -m config window_opacity_duration \(windowOpacityDuration)
yabai -m config active_window_opacity \(activeWindowOpacity)
yabai -m config normal_window_opacity \(normalWindowOpacity)

# Borders
yabai -m config window_border \(windowBorder == true ? "on" : "off")
yabai -m config window_border_width \(windowBorderWidth)
yabai -m config active_window_border_color \"\(activeWindowBorderColor.asHexString)\"
yabai -m config normal_window_border_color \"\(normalWindowBorderColor.asHexString)\"
yabai -m config insert_window_border_color \"\(insertWindowBorderColor.asHexString)\"

# New Window Placement
yabai -m config window_placement \(windowPlacement)

# Auto Balance
yabai -m config auto_balance \(windowBalance == .auto ? "on" : "off")

# Split Ratio
\(windowBalance == .auto ? "#" : "")yabai -m config split_ratio \(windowBalance == .custom ? splitRatio : 0.50)

# Floating Windows Stay-On-Top
yabai -m config window_topmost \(windowTopmost == true ? "on" : "off") #SA

#=========================================================================================
# Mouse
#=========================================================================================
# Mouse Follows Focus
yabai -m config mouse_follows_focus \(mouseFollowsFocus == true ? "on" : "off")

# Focus Follows Mouse
yabai -m config focus_follows_mouse \(!focusFollowsMouseEnabled ? "off" : "\(focusFollowsMouse)")

# Modifier Key
yabai -m config mouse_modifier \(mouseModifier)

# Left Click + Modifier
yabai -m config mouse_action1 \(mouseAction1)

# Right Click + Modifier
yabai -m config mouse_action2 \(mouseAction2)

# Drop Action
yabai -m config mouse_drop_action \(mouseDropAction)

#=========================================================================================
# External Bar
#=========================================================================================
# External Bar top:bottom
yabai -m config external_bar \(!externalBarEnabled ? "off" : "\(externalBar):\(externalBarPaddingTop):\(externalBarPaddingBottom)")

#=========================================================================================
# Misc
#=========================================================================================
# Set-System Preferences Floating
yabai -m rule --add label=\"System Preferences\" app=\"^System Preferences$\" manage=off"

# Load Scripting Addition
sudo yabai --load-sa
yabai -m signal --add event=dock_did_restart action=\"sudo yabai --load-sa\"
"""
    }
}
