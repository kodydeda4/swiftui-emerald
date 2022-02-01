import Foundation
import SwiftShell

struct Config {
  var layout = Layout.float
  var paddingTop = 0
  var paddingBottom = 0
  var paddingLeft = 0
  var paddingRight = 0
  var windowGap = 0
  var windowPlacement = WindowPlacement.first
  var autobalance = false
  var splitRatio = 50
  var mouseFollowsFocus = false
  var focusFollowsMouse = false
  var mouseModifier = MouseModifier.fn
  var mouseAction = false
  var externalBar = false
  var externalBarPaddingTop = 0
  var externalBarPaddingBottom = 0
}

enum WindowPlacement: String {
  case first
  case second
}

enum MouseModifier: String {
  case fn
  case shift
  case ctrl
  case alt
  case cmd
}

enum Layout: String {
  case float
  case bsp
  case stack
}

extension Config: Equatable, Codable {}
extension WindowPlacement     : Equatable, Codable, CaseIterable, Identifiable { var id: Self { self } }
extension MouseModifier       : Equatable, Codable, CaseIterable, Identifiable { var id: Self { self } }
extension Layout              : Equatable, Codable, CaseIterable, Identifiable { var id: Self { self } }

