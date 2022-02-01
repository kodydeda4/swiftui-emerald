import SwiftUI

struct LayoutSettingsView: View {
  @Binding var config: Config
  
  var body: some View {
    List {
      Group {
        Picker("Layout", selection: $config.layout) {
          ForEach(Layout.allCases) {
            Text($0.rawValue)
          }
        }
        Text("Set the layout of the selected space.")
          .foregroundColor(.gray)
      }
      Group {
        Stepper("Gaps \(config.windowGap)", value: $config.windowGap)

        Text("Specify gaps between windows.")
          .foregroundColor(.gray)
      }
      Group {
        Text("Padding")
        
        Text("Specify padding between spaces.")
          .foregroundColor(.gray)
        
        HStack {
          Stepper("Top \(config.paddingTop)", value: $config.paddingTop)
          Stepper("Bottom \(config.paddingBottom)", value: $config.paddingBottom)
          Stepper("Left \(config.paddingLeft)", value: $config.paddingLeft)
          Stepper("Right \(config.paddingRight)", value: $config.paddingRight)
        }
      }
    }
    .navigationTitle("Layout")
  }
}

struct LayoutSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    LayoutSettingsView(config: .constant(Config()))
  }
}
