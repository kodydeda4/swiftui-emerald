//
//  Extensions.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/10/21.
//

import Foundation

public func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
