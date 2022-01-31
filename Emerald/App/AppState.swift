import ComposableArchitecture

struct AppState: Equatable {
  @BindableState var config = Config()
  @BindableState var inFlight = false
}

enum AppAction: BindableAction, Equatable {
  case binding(BindingAction<AppState>)
  case save
  case load
  case apply
  case reset
  case saveResult(Result<Never, AppError>)
  case loadResult(Result<Config, AppError>)
  case applyResult(Result<String, AppError>)
}

struct AppEnvironment {
  let mainQueue: AnySchedulerOf<DispatchQueue>
  let client: AppClient
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
  switch action {
    
  case .binding(\.$config):
    return Effect(value: .save)
    
  case .binding:
    return .none
    
  case .save:
    return environment.client.save(state.config)
      .receive(on: environment.mainQueue)
      .catchToEffect(AppAction.saveResult)
    
  case .load:
    return environment.client.load()
      .receive(on: environment.mainQueue)
      .catchToEffect(AppAction.loadResult)
    
  case .apply:
    state.inFlight = true
    return environment.client.apply()
      .receive(on: environment.mainQueue)
      .catchToEffect(AppAction.applyResult)
    
  case .reset:
    state.config = Config()
    return Effect(value: .save)
  
  // Results
  case let .loadResult(.success(success)):
    state.config = success
    return .none
    
  case .saveResult, .loadResult, .applyResult:
    state.inFlight = false
    return .none
  }
}
.binding()
.debug()


extension AppState {
  static let defaultStore = Store(
    initialState: AppState(),
    reducer: appReducer,
    environment: AppEnvironment(
      mainQueue: .main,
      client: .live
    )
  )
}
