import SwiftUI
import ComposableArchitecture

struct AppView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      HSplitView {
        MainView(config: viewStore.binding(\.$config))
          .padding()
        
        DetailView(config: viewStore.config)
          .background(Color.black)
      }
      .onAppear { viewStore.send(.load) }
      .sheet(isPresented: .constant(viewStore.inFlight)) {
        Text("InFlight")
          .frame(width: 400, height: 600)
      }
      .toolbar {
        ToolbarItemGroup {
          Button("Reset") {
            viewStore.send(.reset)
          }
          Button("Apply Changes") {
            viewStore.send(.apply)
          }
        }
      }
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView(store: AppState.defaultStore)
  }
}
