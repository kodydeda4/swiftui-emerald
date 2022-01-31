import Foundation

extension FileManager {
  /// ~/Library/ApplicationSupport/`Emerald`
  static var applicationSupport: URL {
    let directory = FileManager.default
      .urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
      .appendingPathComponent("Emerald", isDirectory: true)
    
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
  
  
  /// ~/
  static let homeDirectory = URL(fileURLWithPath: NSHomeDirectory())
}
