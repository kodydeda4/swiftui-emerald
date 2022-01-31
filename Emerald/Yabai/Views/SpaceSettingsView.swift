import SwiftUI

struct SpaceSettingsView: View {
  @Binding var config: Config
  
  var body: some View {
    VStack {
      Picker("layout", selection: $config.layout) {
        ForEach(Layout.allCases) {
          Text($0.rawValue)
        }
      }
      HStack {
        Stepper("gaps \(config.windowGap)", value: $config.windowGap)
        Stepper("top \(config.paddingTop)", value: $config.paddingTop)
        Stepper("bottom \(config.paddingBottom)", value: $config.paddingBottom)
        Stepper("left \(config.paddingLeft)", value: $config.paddingLeft)
        Stepper("right \(config.paddingRight)", value: $config.paddingRight)
      }
    }
    .navigationTitle("Layout")
    .padding()
  }
}

struct SpaceSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SpaceSettingsView(config: .constant(Config()))
  }
}
