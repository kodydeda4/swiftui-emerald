//
//  AppleScript.swift
//  Emerald
//
//  Created by Kody Deda on 2/11/21.
//

import Foundation

struct AppleScript {
    
    // Run a shell command with elevated priviledges (Applescript)
    static func execute(_ command: String, sudo: Bool = false) -> Result<Bool, Error> {
        let data: String = "do shell script \"\(command)\" \(sudo ? "with administrator privileges" : "")"
        
        var url: URL {
            try! FileManager.default.url(
                for: .applicationScriptsDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            .appendingPathComponent("AppleScript")
            .appendingPathExtension(for: .osaScript)
        }

        
        do {
            try data.write(to: url, atomically: true, encoding: .utf8)
            try NSUserScriptTask(url: url).execute()
            return .success(true)
        }
        catch {
            return .failure(error)
        }
    }
}
