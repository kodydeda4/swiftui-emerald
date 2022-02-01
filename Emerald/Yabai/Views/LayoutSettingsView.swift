import SwiftUI

struct LayoutSettingsView: View {
  @Binding var config: Config
  
  var body: some View {
    List {
      Picker("Layout", selection: $config.layout) {
        ForEach(Layout.allCases) {
          Text($0.rawValue)
        }
      }
      Text("Set the layout of the selected space.")
        .foregroundColor(.gray)
      
      HStack {
        Stepper("gaps \(config.windowGap)", value: $config.windowGap)
        Stepper("top \(config.paddingTop)", value: $config.paddingTop)
        Stepper("bottom \(config.paddingBottom)", value: $config.paddingBottom)
        Stepper("left \(config.paddingLeft)", value: $config.paddingLeft)
        Stepper("right \(config.paddingRight)", value: $config.paddingRight)
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
