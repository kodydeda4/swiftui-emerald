import SwiftUI
import ComposableArchitecture

struct AppView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      HSplitView {
        MainView(store: store)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        ScrollView {
          Text("Yabai Config")
            .font(.title)
          
          Text(viewStore.config)
            .font(.system(.body, design: .monospaced))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
      }
      .onAppear { viewStore.send(.loadState) }
      .frame(minWidth: 600, minHeight: 600)
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView(store: AppState.defaultStore)
  }
}
