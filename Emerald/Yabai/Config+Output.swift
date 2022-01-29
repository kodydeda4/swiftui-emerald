extension Config { var output: String {
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
#

#===============================================
# Space
#===============================================
# Layout
yabai -m config layout \(layout)

# Padding
yabai -m config top_padding \(paddingTop)
yabai -m config bottom_padding \(paddingBottom)
yabai -m config left_padding \(paddingLeft)
yabai -m config right_padding \(paddingRight)
yabai -m config window_gap \(windowGap)

#===============================================
# Window
#===============================================

# New Window Placement
yabai -m config window_placement \(windowPlacement)

# Auto Balance
yabai -m config auto_balance \(windowBalance == .auto ? "on" : "off")

# Split Ratio
\(windowBalance == .auto ? "#" : "")yabai -m config split_ratio \(windowBalance == .custom ? Float(splitRatio)/100 : 0.50)


#===============================================
# Mouse
#===============================================
# Mouse Follows Focus
yabai -m config mouse_follows_focus \(mouseFollowsFocus == true ? "on" : "off")

# Focus Follows Mouse
yabai -m config focus_follows_mouse \(focusFollowsMouse)")

# Modifier Key
yabai -m config mouse_modifier \(mouseModifier)

# Left Click + Modifier
yabai -m config mouse_action1 \(mouseAction1)

# Right Click + Modifier
yabai -m config mouse_action2 \(mouseAction2)

# Drop Action
yabai -m config mouse_drop_action \(mouseDropAction)

#===============================================
# External Bar
#===============================================
# External Bar top:bottom
yabai -m config external_bar \(externalBar):\(externalBarPaddingTop):\(externalBarPaddingBottom)")
"""
}}
