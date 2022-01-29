import Foundation
import SwiftShell

struct YabaiConfig {
  var paddingTop = 0
  var paddingBottom = 0
  var paddingLeft = 0
  var paddingRight = 0
  var windowGap = 0
  var layout: YabaiLayout = .float
}

extension YabaiConfig: Equatable, Codable {}
