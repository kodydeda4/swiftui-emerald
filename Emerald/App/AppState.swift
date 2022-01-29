import ComposableArchitecture
import SwiftShell

struct AppState: Equatable, Codable {
  var inFlight = false
  @BindableState var yabai = Yabai()
  @BindableState var sheet = false
}

enum AppAction: BindableAction, Equatable {
  case binding(BindingAction<AppState>)
  
  case saveState
  case loadState
  case saveStateResult(Result<Never, AppError>)
  case loadStateResult(Result<AppState, AppError>)
  
  case saveConfig
  case loadConfig
  case saveConfigResult(Result<Never, AppError>)
  case loadConfigResult(Result<String, AppError>)
}

struct AppEnvironment {
  let mainQueue: AnySchedulerOf<DispatchQueue>
  let localDataClient: AppClient
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
  switch action {
    
  case .binding:
    return Effect(value: .saveState)
    
  case .saveState:
    state.inFlight = true
    return environment.localDataClient.saveState(state)
      .receive(on: environment.mainQueue)
      .catchToEffect(AppAction.saveStateResult)
    
  case .loadState:
    state.inFlight = true
    return environment.localDataClient.loadState()
      .receive(on: environment.mainQueue)
      .catchToEffect(AppAction.loadStateResult)
    
  case .saveStateResult(.success):
    state.inFlight = false
    return Effect(value: .saveConfig)
    
  case let .saveStateResult(.failure(error)):
    state.inFlight = false
    //state.error = error
    return .none
    
  case let .loadStateResult(.success(success)):
    state = success
    state.inFlight = false
    return .none
    
  case let .loadStateResult(.failure(error)):
    state.inFlight = false
    //state.error = error
    return .none
    
  case .saveConfig:
    state.inFlight = true
    return environment.localDataClient.saveConfig(state.yabai)
      .receive(on: environment.mainQueue)
      .catchToEffect(AppAction.saveConfigResult)
    
  case .loadConfig:
    state.inFlight = true
    return environment.localDataClient.loadConfig()
      .receive(on: environment.mainQueue)
      .catchToEffect(AppAction.loadConfigResult)
    
  case .saveConfigResult(.success):
    state.inFlight = false
    return .none
    
  case let .saveConfigResult(.failure(error)):
    state.inFlight = false
    //state.error = error
    return .none
    
  case let .loadConfigResult(.success(success)):
    //    state.config = success
    state.inFlight = false
    return .none
    
  case let .loadConfigResult(.failure(error)):
    state.inFlight = false
    //state.error = error
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
      localDataClient: .live
    )
  )
}
