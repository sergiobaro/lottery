import Foundation

struct SearchViewModel {
  
  let message: String
  
  static func empty() -> Self {
    return .init(message: "")
  }
}
