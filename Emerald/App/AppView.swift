import SwiftUI
import ComposableArchitecture

struct AppView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        MainView(yabai: viewStore.binding(\.$yabai))
          .padding()
        
        ConfigView(viewStore.yabai.config)
          .padding()
      }
      .onAppear { viewStore.send(.loadState) }
      .frame(minWidth: 600, minHeight: 600)
      .toolbar {
        Toggle("Readme", isOn: viewStore.binding(\.$sheet))
      }
      .sheet(isPresented: viewStore.binding(\.$sheet)) {
        ReadMeView(isPresented: viewStore.binding(\.$sheet))
      }
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView(store: AppState.defaultStore)
  }
}
