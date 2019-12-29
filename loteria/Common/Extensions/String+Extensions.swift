import Foundation

extension Substring {
  func asString() -> String {
    return String(self)
  }
}

extension String {
  func asInt() -> Int {
    return Int(self) ?? 0
  }
}
