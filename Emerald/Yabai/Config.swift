import Foundation
import SwiftShell

struct Config {
  var layout = Layout.float
  var paddingTop = 0
  var paddingBottom = 0
  var paddingLeft = 0
  var paddingRight = 0
  var windowGap = 0
  var windowPlacement = WindowPlacement.first_child
  var windowBalance = WindowBalance.normal
  var splitRatio = 50
  var mouseFollowsFocus = false
  var focusFollowsMouse = FocusFollowsMouse.off
  var mouseModifier = MouseModifier.fn
  var mouseAction1 = MouseAction.move
  var mouseAction2 = MouseAction.resize
  var mouseDropAction = MouseDropAction.swap
  var externalBar = ExternalBar.disabled
  var externalBarPaddingTop = 0
  var externalBarPaddingBottom = 0
}

enum ExternalBar: String {
  case disabled
  case all
  case main
}

enum FocusFollowsMouse: String {
  case off
  case autofocus
  case autoraise
}

enum WindowPlacement: String {
  case first_child
  case second_child
}

enum MouseModifier: String {
  case fn
  case shift
  case ctrl
  case alt
  case cmd
}

enum MouseAction: String {
  case move
  case resize
}

enum MouseDropAction: String {
  case swap
  case stack
}

enum Layout: String {
  case float
  case bsp
  case stack
}

enum WindowBalance: String {
  case normal
  case auto
  case custom
}

extension Config: Equatable, Codable {}

extension ExternalBar       : Equatable, Codable, CaseIterable, Identifiable { var id: Self { self } }
extension FocusFollowsMouse : Equatable, Codable, CaseIterable, Identifiable { var id: Self { self } }
extension WindowPlacement   : Equatable, Codable, CaseIterable, Identifiable { var id: Self { self } }
extension MouseModifier     : Equatable, Codable, CaseIterable, Identifiable { var id: Self { self } }
extension MouseAction       : Equatable, Codable, CaseIterable, Identifiable { var id: Self { self } }
extension MouseDropAction   : Equatable, Codable, CaseIterable, Identifiable { var id: Self { self } }
extension Layout            : Equatable, Codable, CaseIterable, Identifiable { var id: Self { self } }
extension WindowBalance     : Equatable, Codable, CaseIterable, Identifiable { var id: Self { self } }

