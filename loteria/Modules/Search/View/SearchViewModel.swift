import Foundation

struct SearchViewModel {
  
  let prizeMessage: String
  let message: String
  
  static func empty() -> Self {
    return Self(prizeMessage: "", message: "")
  }
}
