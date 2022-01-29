import Foundation

extension YabaiConfig { var output: String {
  
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


#=============================================
# Space
#=============================================
# Layout
yabai -m config layout \(layout)

# Padding
yabai -m config top_padding \(paddingTop)
yabai -m config bottom_padding \(paddingBottom)
yabai -m config left_padding \(paddingLeft)
yabai -m config right_padding \(paddingRight)
yabai -m config window_gap \(windowGap)







"""
} }
