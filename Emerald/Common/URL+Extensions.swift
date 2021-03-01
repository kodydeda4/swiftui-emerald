//
//  Extensions.swift
//  Emerald
//
//  Created by Kody Deda on 2/10/21.
//

import Foundation

public func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

public func getApplicationSupportDirectory() -> URL {
    let paths = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
    return paths[0]
}

