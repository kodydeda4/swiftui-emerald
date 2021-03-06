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
# TEMPORARILY HARDCODED
#=========================================================================================
yabai -m rule --add label=\"System Preferences\" app=\"^System Preferences$\" manage=off"

#=========================================================================================
# General
#=========================================================================================
yabai -m config debug_output \(debugOutput == true ? "on" : "off")
yabai -m config external_bar \(externalBar):\(externalBarPaddingTop):\(externalBarPaddingBottom)
yabai -m config mouse_follows_focus \(mouseFollowsFocus == true ? "on" : "off")
yabai -m config focus_follows_mouse \(focusFollowsMouse)

#=========================================================================================
# Window Misc
#=========================================================================================
yabai -m config window_placement \(windowPlacement)
yabai -m config window_shadow \(windowShadow)

#=========================================================================================
# Window Opacity
#=========================================================================================
yabai -m config window_opacity \(windowOpacity == true ? "on" : "off")
yabai -m config window_opacity_duration \(Float(windowOpacityDuration)/100)
yabai -m config active_window_opacity \(Float(activeWindowOpacity)/100)
yabai -m config normal_window_opacity \(Float(normalWindowOpacity)/100)

#=========================================================================================
# Window Borders
#=========================================================================================
yabai -m config window_border \(windowBorder == true ? "on" : "off")
yabai -m config window_border_width \(windowBorderWidth)
yabai -m config active_window_border_color \"\(activeWindowBorderColor.asHexString)\"
yabai -m config normal_window_border_color \"\(normalWindowBorderColor.asHexString)\"
yabai -m config insert_window_border_color \"\(insertWindowBorderColor.asHexString)\"

#=========================================================================================
# Misc
#=========================================================================================
yabai -m config split_ratio \(Float(splitRatio/100))
yabai -m config auto_balance \(autoBalance == true ? "on" : "off")

#=========================================================================================
# Mouse Actions",
#=========================================================================================
yabai -m config mouse_modifier \(mouseModifier)
yabai -m config mouse_action1 \(mouseAction1)
yabai -m config mouse_action2 \(mouseAction2)
yabai -m config mouse_drop_action \(mouseDropAction)

#=========================================================================================
# Space Settings
#=========================================================================================
yabai -m config layout \(layout)
yabai -m config top_padding \(paddingTop)
yabai -m config bottom_padding \(paddingBottom)
yabai -m config left_padding \(paddingLeft)
yabai -m config right_padding \(paddingRight)
yabai -m config window_gap \(windowGap)

#=========================================================================================
# Load Scripting Addition
#=========================================================================================
sudo yabai --load-sa
yabai -m signal --add event=dock_did_restart action=\"sudo yabai --load-sa\"

#=========================================================================================
# Scripting Addition Options
#=========================================================================================
yabai -m config window_topmost \(windowTopmost == true ? "on" : "off")
"""
    }
}
