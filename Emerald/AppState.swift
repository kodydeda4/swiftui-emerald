import ComposableArchitecture

struct AppState: Equatable {
  @BindableState var padding = 0
}

enum AppAction: BindableAction, Equatable {
  case binding(BindingAction<AppState>)
}

struct AppEnvironment {
  
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
  switch action {
  case .binding:
    return .none
  }
}.binding()


extension AppState {
  static let defaultStore = Store(
    initialState: AppState(),
    reducer: appReducer,
    environment: AppEnvironment()
  )
}
