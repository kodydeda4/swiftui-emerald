import SwiftUI

struct MouseSettingsView: View {
  @Binding var config: Config
  
  var body: some View {
    VStack {
      Toggle("Mouse Follows Focus", isOn: $config.mouseFollowsFocus)
      
      Picker("Focus Follows Mouse", selection: $config.focusFollowsMouse) {
        ForEach(FocusFollowsMouse.allCases) {
          Text($0.rawValue)
        }
      }
      Picker("Modifier Key", selection: $config.mouseModifier) {
        ForEach(MouseModifier.allCases) {
          Text($0.rawValue)
        }
      }
      Picker("Left Click + Modifier", selection: $config.mouseAction1) {
        ForEach(MouseAction.allCases) {
          Text($0.rawValue)
        }
      }
      Picker("Right Click + Modifier", selection: $config.mouseAction2) {
        ForEach(MouseAction.allCases) {
          Text($0.rawValue)
        }
      }
      Picker("Drop Action", selection: $config.mouseDropAction) {
        ForEach(MouseDropAction.allCases) {
          Text($0.rawValue)
        }
      }
    }
    .navigationTitle("Mouse")
    .padding()
  }
}

struct MouseSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    MouseSettingsView(config: .constant(Config()))
  }
}
