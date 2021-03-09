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
\(KeyboardShortcuts.getShortcut(for: .restartYabai)?.description   ?? "#<UNASSIGNED>") \"/bin/launchctl kickstart -k \"gui/${UID}/homebrew.mxcl.yabai\"
\(KeyboardShortcuts.getShortcut(for: .togglePadding)?.description  ?? "#<UNASSIGNED>") : yabai -m space --toggle padding
\(KeyboardShortcuts.getShortcut(for: .toggleGaps)?.description     ?? "#<UNASSIGNED>") : yabai -m space --toggle gap
\(KeyboardShortcuts.getShortcut(for: .toggleSplit)?.description    ?? "#<UNASSIGNED>") : yabai -m window --toggle split
\(KeyboardShortcuts.getShortcut(for: .toggleBalance)?.description  ?? "#<UNASSIGNED>") : yabai -m space --balance
\(KeyboardShortcuts.getShortcut(for: .toggleStacking)?.description ?? "#<UNASSIGNED>") : yabai -m space --layout stack
\(KeyboardShortcuts.getShortcut(for: .toggleFloating)?.description ?? "#<UNASSIGNED>") : yabai -m space --layout float
\(KeyboardShortcuts.getShortcut(for: .toggleBSP)?.description      ?? "#<UNASSIGNED>") : yabai -m space --layout bsp
"""
    }
}

