import ComposableArchitecture

struct AppClient {
  let saveState: (AppState) -> Effect<AppState, AppError>
  let loadState: () -> Effect<AppState, AppError>
  
  let saveConfig: (String) -> Effect<String, AppError>
  let loadConfig: () -> Effect<String, AppError>
}

extension AppClient {
  static let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    .appendingPathComponent("AppState")
  
  static let configURL = URL(fileURLWithPath: NSHomeDirectory())
    .appendingPathComponent("YabaiConfig")
  
  static let `live` = Self(
    saveState: { state in
      Effect.future { callback in
        do {
          try JSONEncoder()
            .encode(state)
            .write(to: url)
          return state |> Result.success >>> callback
        } catch {
          return "Failed to encode" |> AppError.init >>> Result.failure >>> callback
        }
      }
    },
    loadState: {
      Effect.future { callback in
        do {
          let decoded = try JSONDecoder()
            .decode(AppState.self, from: Data(contentsOf: url))
          return decoded |> Result.success >>> callback
        }
        catch {
          return "Failed to decode" |> AppError.init >>> Result.failure >>> callback
        }
      }
    },
    saveConfig: { config in
      Effect.future { callback in
        do {
          let data: String = config
          try data.write(to: configURL, atomically: true, encoding: .utf8)
          return config |> Result.success >>> callback
        }
        catch {
          return error |> AppError.init >>> Result.failure >>> callback
        }
      }
    },
    loadConfig: {
      Effect.future { callback in
        do {
          let decoded = try JSONDecoder()
            .decode(String.self, from: Data(contentsOf: url))
          return decoded |> Result.success >>> callback
        }
        catch {
          return "Failed to decode" |> AppError.init >>> Result.failure >>> callback
        }
      }
    }
  )
}


