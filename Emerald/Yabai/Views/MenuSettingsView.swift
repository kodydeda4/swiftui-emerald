import SwiftUI

struct MenuSettingsView: View {
  @Binding var config: Config
  
  var body: some View {
    List {
      Toggle("External Menu", isOn: $config.externalBar)
      
      Text("Specify top and bottom padding for a custom bar you may be running")
        .foregroundColor(.gray)

      HStack {
        Stepper("Top \(config.externalBarPaddingTop)", value: $config.externalBarPaddingTop)
        Stepper("Bottom \(config.externalBarPaddingBottom)", value: $config.externalBarPaddingBottom)
      }
      .disabled(!config.externalBar)
      .opacity(config.externalBar ? 1 : 0.5)
    }
    .navigationTitle("Menu")
  }
}
struct MenuSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    MenuSettingsView(config: .constant(Config()))
  }
}
