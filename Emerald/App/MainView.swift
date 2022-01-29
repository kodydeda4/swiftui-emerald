import SwiftUI
import ComposableArchitecture

struct MainView: View {
  @Binding var yabai: Yabai
  
  
  var body: some View {
    Form {
      //        Text("Inflight: \(viewStore.inFlight.description)")
      //          .opacity(viewStore.inFlight ? 1 : 0)
      //
      //        Text("Error: \(viewStore.error?.localizedDescription ?? "")")
      //          .opacity(viewStore.error != nil ? 1 : 0)
      
      Stepper("Top Padding \(yabai.paddingTop)", value: $yabai.paddingTop)
      Stepper("Bottom Padding \(yabai.paddingBottom)", value: $yabai.paddingBottom)
      Stepper("Left Padding \(yabai.paddingLeft)", value: $yabai.paddingLeft)
      Stepper("Right Padding \(yabai.paddingRight)", value: $yabai.paddingRight)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(yabai: .constant(Yabai()))
  }
}
