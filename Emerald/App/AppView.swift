import SwiftUI
import ComposableArchitecture

struct AppView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        MainView(config: viewStore.binding(\.$config))
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding()
          
        DetailView(config: viewStore.config)
          .padding()
      }
      .onAppear { viewStore.send(.load) }
      .frame(minWidth: 600, minHeight: 600)
      .toolbar {
        ToolbarItemGroup {
          Button("Reset") {
            viewStore.send(.reset)
          }
          Button("Apply Changes") {
            viewStore.send(.applyChanges)
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
