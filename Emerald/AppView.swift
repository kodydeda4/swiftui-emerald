import SwiftUI
import ComposableArchitecture

struct AppView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
        Form {
          Stepper("Padding \(viewStore.padding)", value: viewStore.binding(\.$padding))
        }
        .frame(minWidth: 400, minHeight: 400)
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView(store: AppState.defaultStore)
  }
}
