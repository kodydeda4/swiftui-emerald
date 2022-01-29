import Foundation

extension FileManager {
  /// Creates & returns Directory at: ~/Library/ApplicationSupport/`name`
  static func applicationSupportDirectory(
    for application: String = "Emerald"
  ) -> URL {
    let directory = FileManager.default
      .urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
      .appendingPathComponent(application, isDirectory: true)

    if !FileManager.default.fileExists(atPath: directory.path) {
      do {
        try FileManager.default.createDirectory(
          atPath: directory.path,
          withIntermediateDirectories: true,
          attributes: nil
        )
      } catch {
        print(error.localizedDescription)
      }
    }
    return directory
  }
}
