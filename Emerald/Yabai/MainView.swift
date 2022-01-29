import SwiftUI

struct MainView: View {
  @Binding var config: YabaiConfig
  
  var body: some View {
    Form {
      Stepper("Top Padding \(config.paddingTop)", value: $config.paddingTop)
      Stepper("Bottom Padding \(config.paddingBottom)", value: $config.paddingBottom)
      Stepper("Left Padding \(config.paddingLeft)", value: $config.paddingLeft)
      Stepper("Right Padding \(config.paddingRight)", value: $config.paddingRight)
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(config: .constant(YabaiConfig()))
  }
}
