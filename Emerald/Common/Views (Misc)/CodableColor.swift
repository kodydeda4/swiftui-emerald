//
//  CodableColor.swift
//  Emerald
//
//  Created by Kody Deda on 3/2/21.
//

import SwiftUI
import DynamicColor

public struct CodableColor {
  var color: Color
}

extension CodableColor: Codable, Equatable {
  public func encode(to encoder: Encoder) throws {
    let nsCoder = NSKeyedArchiver(requiringSecureCoding: true)
    NSColor(color).encode(with: nsCoder)
    var container = encoder.unkeyedContainer()
    try container.encode(nsCoder.encodedData)
  }
  
  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    let decodedData = try container.decode(Data.self)
    let nsCoder = try NSKeyedUnarchiver(forReadingFrom: decodedData)
    guard let color = NSColor(coder: nsCoder) else {
      struct UnexpectedlyFoundNilError: Error {}
      throw UnexpectedlyFoundNilError()
    }
    self.color = Color(color)
  }
}

extension CodableColor {
  var asHexString: String {
    "0xff\(DynamicColor(color).toHexString().dropFirst())"
  }
}

public extension NSColor {
  func codable() -> CodableColor {
    return CodableColor(color: Color(self))
  }
}
