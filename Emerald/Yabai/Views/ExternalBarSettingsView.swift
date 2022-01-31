import SwiftUI

struct ExternalBarSettingsView: View {
  @Binding var config: Config
  
  var body: some View {
    VStack {
      Picker("External Bar", selection: $config.externalBar) {
        ForEach(ExternalBar.allCases) {
          Text($0.rawValue)
        }
      }
      HStack {
        Stepper("Padding Top \(config.externalBarPaddingTop)", value: $config.externalBarPaddingTop)
        Stepper("Padding Bottom \(config.externalBarPaddingBottom)", value: $config.externalBarPaddingBottom)
      }
      .disabled(config.externalBar == .disabled)
      .opacity(config.externalBar == .disabled ? 0.5 : 1)
    }
    .navigationTitle("Menu")
    .padding()
  }
}
struct ExternalBarSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    ExternalBarSettingsView(config: .constant(Config()))
  }
}
