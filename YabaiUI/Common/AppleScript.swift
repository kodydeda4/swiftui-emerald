//
//  AppleScript.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/11/21.
//

import Foundation

enum AppleScript: String {
    case refreshYabai = "refreshYabai"
    case yabaiSetFloating = "yabaiSetFloating"
    case yabaiSetBSP = "yabaiSetBSP"
    case yabaiSetStacking = "yabaiSetStacking"
}

extension AppleScript {
    var url: URL {
        try! FileManager.default.url(
            for: .applicationScriptsDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        .appendingPathComponent(rawValue)
        .appendingPathExtension(for: .osaScript)
    }
    
    func execute() -> String {
        do {
            try NSUserScriptTask(url: url).execute()
            return "\(rawValue) was executed successfully."
        } catch {
            return error.localizedDescription
        }
    }
}
