//
//  SKHDConfigFile.swift
//  Emerald
//
//  Created by Kody Deda on 3/3/21.
//

import Foundation
import KeyboardShortcuts

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
#   ~/\(configURL.relativePath)
#   \(version)
#

.blacklist [\"YabaiUI\"]
            
#============================================
# Section A
#============================================
\(KeyboardShortcuts.getShortcut(for: .restartYabai)?.asSKHDString   ?? "#<UNASSIGNED>") : \"/bin/launchctl kickstart -k \"gui/${UID}/homebrew.mxcl.yabai\"
\(KeyboardShortcuts.getShortcut(for: .togglePadding)?.asSKHDString  ?? "#<UNASSIGNED>") : yabai -m space --toggle padding
\(KeyboardShortcuts.getShortcut(for: .toggleGaps)?.asSKHDString     ?? "#<UNASSIGNED>") : yabai -m space --toggle gap
\(KeyboardShortcuts.getShortcut(for: .toggleSplit)?.asSKHDString    ?? "#<UNASSIGNED>") : yabai -m window --toggle split
\(KeyboardShortcuts.getShortcut(for: .toggleBalance)?.asSKHDString  ?? "#<UNASSIGNED>") : yabai -m space --balance
\(KeyboardShortcuts.getShortcut(for: .toggleStacking)?.asSKHDString ?? "#<UNASSIGNED>") : yabai -m space --layout stack
\(KeyboardShortcuts.getShortcut(for: .toggleFloating)?.asSKHDString ?? "#<UNASSIGNED>") : yabai -m space --layout float
\(KeyboardShortcuts.getShortcut(for: .toggleBSP)?.asSKHDString      ?? "#<UNASSIGNED>") : yabai -m space --layout bsp
"""
    }
}

extension KeyboardShortcuts.Shortcut {
    var asSKHDString: String {
        return "SKHD<\(description)>"
    }
}

// Can't get f7 as F+7 -> if there's F followed by 1-2 digits then combine those as one button :s
