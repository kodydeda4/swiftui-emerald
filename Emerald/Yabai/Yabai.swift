import Foundation
import SwiftShell

struct Yabai {
  var version = run("/usr/local/bin/yabai", "-v").stdout
  var configURL = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("YabaiConfig")
  

  var paddingTop = 0
  var paddingBottom = 0
  var paddingLeft = 0
  var paddingRight = 0
  var windowGap = 0
  
  var layout: YabaiLayout = .float
}

enum YabaiLayout {
  case float
  case bsp
  case stack
}


extension Yabai: Equatable, Codable {}
extension YabaiLayout: Codable {}
