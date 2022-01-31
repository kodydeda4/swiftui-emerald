import Combine
import ComposableArchitecture

private let url = try! FileManager.default
  .url(for: .applicationScriptsDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
  .appendingPathComponent("AppleScript")
  .appendingPathExtension(for: .osaScript)

private extension String {
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

extension NSUserAppleScriptTask {
  func execute() -> Future<String, Error> {
    Future<String, Error> { callback in
      self.execute {
        if let error = $0 {
          callback(.failure(error))
        }
        else {
          callback(.success("Successfuly Completed."))
        }
      }
    }
  }
}

struct Applescript {
  static func execute(sudo: Bool = false, command: String) -> Future<String, Error> {
    let cmd = sudo ? "do shell script \"\(command)\" with administrator privileges" : command
      
    return String(cmd)
      .write(to: url)
      .pipe { try! NSUserAppleScriptTask(url: $0) }
      .execute()
  }
}




