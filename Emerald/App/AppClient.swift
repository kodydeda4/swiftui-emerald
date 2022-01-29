import Combine
import ComposableArchitecture

struct AppClient {
  let save: (
    _ yabai: Config,
    _ stateURL: URL,
    _ configURL: URL
  ) -> Effect<Never, AppError>
  
  let load: (_ stateURL: URL) -> Effect<Config, AppError>
  
  let applyChanges: () -> Effect<String, AppError>
}

extension AppClient {
  static let `live` = Self(
    save: { config, stateURL, configURL in
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
    load: { stateURL in
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
    applyChanges: {
      Applescript
        .execute(command: "brew services restart yabai")
        .mapError(AppError.init)
        .eraseToEffect()
    }
  )
}

