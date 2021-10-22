//
//  Extensions.swift
//  Emerald
//
//  Created by Kody Deda on 2/10/21.
//

import Foundation

extension URL {
  static let HomeDirectory               = URL(fileURLWithPath: NSHomeDirectory())
  static let ApplicationSupportDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
  static let UserDocumentsDirectory      = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
}
