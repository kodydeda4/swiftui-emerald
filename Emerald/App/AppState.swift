import ComposableArchitecture

struct AppState: Equatable {
  var inFlight = false
  @BindableState var config = YabaiConfig()
  @BindableState var stateURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent("AppState")
  @BindableState var configURL = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("YabaiConfig")
}

enum AppAction: BindableAction, Equatable {
  case binding(BindingAction<AppState>)
  case save
  case load
  case saveResult(Result<Never, AppError>)
  case loadResult(Result<YabaiConfig, AppError>)
}

struct AppEnvironment {
  let mainQueue: AnySchedulerOf<DispatchQueue>
  let client: AppClient
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
  switch action {
    
  case .binding:
    return Effect(value: .save)
    
  case .save:
    return environment.client
      .save(state.config, state.stateURL, state.configURL)
      .receive(on: environment.mainQueue)
      .catchToEffect(AppAction.saveResult)
        
  case let .saveResult(.failure(error)):
    print(error.localizedDescription)
    return .none
    
  case .load:
    state.inFlight = true
    return environment.client.load(state.stateURL)
      .receive(on: environment.mainQueue)
      .catchToEffect(AppAction.loadResult)
        
  case let .loadResult(.success(success)):
    state.config = success
    return .none
    
  case let .loadResult(.failure(error)):
    print(error.localizedDescription)
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
