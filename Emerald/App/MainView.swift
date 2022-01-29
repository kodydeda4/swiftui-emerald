import SwiftUI
import ComposableArchitecture

struct MainView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack {
        Text("Inflight: \(viewStore.inFlight.description)")
          .opacity(viewStore.inFlight ? 1 : 0)
        
        Text("Error: \(viewStore.error?.localizedDescription ?? "")")
          .opacity(viewStore.error != nil ? 1 : 0)
        
        Stepper(
          "Padding \(viewStore.padding)",
          value: viewStore.binding(\.$padding)
        )
      }
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(store: AppState.defaultStore)
  }
}
