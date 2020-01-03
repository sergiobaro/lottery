import Foundation

struct SearchViewModel {
  
  let prizeMessage: String
  let message: String
  
  static func empty() -> Self {
    return .init(prizeMessage: "", message: "")
  }
}
