import Combine
import ComposableArchitecture

struct AppClient {
  let save: (
    _ yabai: YabaiConfig,
    _ stateURL: URL,
    _ configURL: URL
  ) -> Effect<Never, AppError>
  
  let load: (_ stateURL: URL) -> Effect<YabaiConfig, AppError>
}

extension AppClient {
  static let `live` = Self(
    save: { yabaiConfig, stateURL, configURL in
      Effect.future { callback in
        do {
          try JSONEncoder().encode(yabaiConfig).write(to: stateURL)
          try yabaiConfig.output.write(to: configURL, atomically: true, encoding: .utf8)
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
          let state = try JSONDecoder().decode(YabaiConfig.self, from: Data(contentsOf: stateURL))
          return callback(.success(state))
        }
        catch {
          return callback(.failure(AppError("Failed to load")))
        }
      }
    }
  )
}

