//
//  SKHDConfigFile.swift
//  Emerald
//
//  Created by Kody Deda on 3/3/21.
//

import Foundation

extension SKHD.State {
    var asConfig: String {
"""
#
#
#   ███████╗██╗  ██╗██╗  ██╗██████╗
#   ██╔════╝██║ ██╔╝██║  ██║██╔══██╗
#   ███████╗█████╔╝ ███████║██║  ██║
#   ╚════██║██╔═██╗ ██╔══██║██║  ██║
#   ███████║██║  ██╗██║  ██║██████╔╝
#   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝
#
#   ~/\(configFilename.relativePath)
#   \(version)
#

.blacklist [\"YabaiUI\"]
            
#=========================================================================================
# Section A
#=========================================================================================
\(skhd(restartYabai)) \"/bin/launchctl kickstart -k \"gui/${UID}/homebrew.mxcl.yabai\"
\(skhd(togglePaddingShortcut)) : yabai -m space --toggle padding
\(skhd(toggleGapsShortcut)) : yabai -m space --toggle gap
\(skhd(toggleSplitShortcut)) : yabai -m window --toggle split
\(skhd(toggleBalanceShortcut)) : yabai -m space --balance
\(skhd(toggleStackingShortcut)) : yabai -m space --layout stack
\(skhd(toggleFloatingShortcut)) : yabai -m space --layout float
\(skhd(toggleBSPShortcut)) : yabai -m space --layout bsp
"""
    }
}
