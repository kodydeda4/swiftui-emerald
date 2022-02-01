import SwiftUI

struct BalanceSettingsView: View {
  @Binding var config: Config
  
  var body: some View {
    List {
      Group {
        Picker("Placement", selection: $config.windowPlacement) {
          ForEach(WindowPlacement.allCases) {
            Text($0.rawValue)
          }
        }
        Text("Specify whether managed windows should become the first or second leaf-node.")
          .foregroundColor(.gray)
      }
      Group {
        Stepper("Split \(config.splitRatio)%", value: $config.splitRatio)
          .disabled(config.autobalance)
          .opacity(config.autobalance ? 0 : 1)
        
        Text("Default split ratio.")
          .foregroundColor(.gray)
      }
    }
    .navigationTitle("Balance")
  }
}

struct BalanceSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    BalanceSettingsView(config: .constant(Config()))
  }
}
