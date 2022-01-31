import SwiftUI

struct WindowSettingsView: View {
  @Binding var config: Config
  
  var body: some View {
    VStack {
      Picker("placement", selection: $config.windowPlacement) {
        ForEach(WindowPlacement.allCases) {
          Text($0.rawValue)
        }
      }
      HStack {
        Picker("balance", selection: $config.windowBalance) {
          ForEach(WindowBalance.allCases) {
            Text($0.rawValue)
          }
        }
        Stepper("split \(config.splitRatio)%", value: $config.splitRatio)
          .disabled(config.windowBalance != .custom)
          .opacity(config.windowBalance == .custom ? 1 : 0.5)
      }
    }
    .navigationTitle("Balance")
    .padding()
  }
}

struct WindowSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    WindowSettingsView(config: .constant(Config()))
  }
}
