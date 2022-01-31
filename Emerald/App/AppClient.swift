import Combine
import ComposableArchitecture

struct AppClient {
  let install: () -> Effect<String, AppError>
  let save: (Config) -> Effect<Never, AppError>
  let load: () -> Effect<Config, AppError>
  let apply: () -> Effect<String, AppError>
}

extension AppClient {
  static var `live`: Self {
    let stateURL = FileManager.applicationSupport.appendingPathComponent("AppState")
    let configURL = FileManager.homeDirectory.appendingPathComponent(".yabairc")
    
    return Self(
      install: {
        Applescript
          .execute(sudo: true, command: "brew services install yabai")
          .mapError(AppError.init)
          .eraseToEffect()
      },
      save: { config in
        Effect.future { callback in
          do {
            try JSONEncoder().encode(config).write(to: stateURL)
            try config.output.write(to: configURL, atomically: true, encoding: .utf8)
            return
          }
          catch {
            return callback(.failure(AppError("Failed to save")))
          }
        }
      },
      load: {
        Effect.future { callback in
          do {
            let state = try JSONDecoder().decode(Config.self, from: Data(contentsOf: stateURL))
            return callback(.success(state))
          }
          catch {
            return callback(.failure(AppError("Failed to load")))
          }
        }
      },
      apply: {
        Applescript
          .execute(command: "brew services restart yabai")
          .mapError(AppError.init)
          .eraseToEffect()
      }
    )
  }
}
