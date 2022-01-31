import SwiftUI
import ComposableArchitecture

struct AppView: View {
  let store: Store<AppState, AppAction>
  @State var sidebar = true
  
  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationView {
        SidebarView(config: viewStore.binding(\.$config))
        MainView()
          DetailView(config: viewStore.config)
      }
      .frame(width: 1920/2, height: 1080/2)
      .onAppear { viewStore.send(.load) }
      .sheet(isPresented: .constant(viewStore.inFlight)) {
        Text("InFlight")
          .padding()
      }
      .toolbar {
        ToolbarItemGroup {
          Button("Reset") {
            viewStore.send(.reset)
          }
          Button("Apply Changes") {
            viewStore.send(.apply)
          }
          Button(action: { sidebar.toggle() }) {
            Image(systemName: "sidebar.squares.right")
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
