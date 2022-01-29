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
      Applescript.execute(command: "brew services restart yabai")
    }
  )
}

struct Applescript {
  static func execute(command: String) -> Effect<String, AppError> {
    Effect.future { callback in
      String("do shell script \"\(command)\" with administrator privileges")
        .write(to: applescriptURL)
        .pipe { try! NSUserAppleScriptTask(url: $0) }
        .execute {
          if let error = $0 {
            return callback(.failure(.init(error)))
          }
          else {
            return callback(.success("Successfuly Completed."))
          }
        }
    }
  }
}

extension String {
  func write(to url: URL) -> URL {
    try! self.write(to: url, atomically: true, encoding: .utf8)
    return url
  }
}
private extension URL {
  func pipe<T>(_ f: (Self) -> T) -> T {
    f(self)
  }
}
extension URL {
  var appleScriptFormat: String {
    "\\\"\(self.path)\\\""
  }
}
let applescriptURL = try! FileManager.default
  .url(for: .applicationScriptsDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
  .appendingPathComponent("AppleScript")
  .appendingPathExtension(for: .osaScript)
