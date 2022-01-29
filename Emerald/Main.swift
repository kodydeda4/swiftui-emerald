import SwiftUI

@main
struct EmeraldApp: App {
  var body: some Scene {
    WindowGroup {
      AppView(store: AppState.defaultStore)
    }
  }
}
