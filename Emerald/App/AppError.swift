import Foundation

struct AppError: Error, Codable, Equatable {
  let rawValue: String
  
  init(_ rawValue: Error) {
    self.rawValue = rawValue.localizedDescription
  }
  
  init(_ rawValue: String) {
    self.rawValue = rawValue
  }
}
