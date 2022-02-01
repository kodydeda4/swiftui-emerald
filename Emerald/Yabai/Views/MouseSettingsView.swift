import SwiftUI

struct MouseSettingsView: View {
  @Binding var config: Config
  
  var body: some View {
    Form {
      Group {
        Toggle("Autofocus", isOn: $config.focusFollowsMouse)
        Text("Automatically focus the window under the mouse.")
          .foregroundColor(.gray)
          
      }
      Group {
        Toggle("Autocenter", isOn: $config.mouseFollowsFocus)
        Text("When focusing a window, put the mouse at its center.")
          .foregroundColor(.gray)
      }
      Group {
        Toggle("Resize Windows", isOn: $config.mouseAction)
        Text("Hold shift & drag to resize windows in bsp.")
          .foregroundColor(.gray)
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
