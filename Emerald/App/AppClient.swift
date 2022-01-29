import ComposableArchitecture


struct AppClient {
  let saveState: (AppState) -> Effect<Never, AppError>
  let loadState: () -> Effect<AppState, AppError>
  
  let saveConfig: (Yabai) -> Effect<Never, AppError>
  let loadConfig: () -> Effect<String, AppError>
}

extension AppClient {
  static let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    .appendingPathComponent("AppState")
  
  
  static let `live` = Self(
    saveState: { state in
      Effect.future { callback in
        do {
          try JSONEncoder()
            .encode(state)
            .write(to: url)
          return// state |> Result.success >>> callback
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
    saveConfig: { yabai in
      Effect.future { callback in
        do {
          let data: String = yabai.config
          try data.write(to: yabai.configURL, atomically: true, encoding: .utf8)
          return// yabai |> Result.success >>> callback
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


