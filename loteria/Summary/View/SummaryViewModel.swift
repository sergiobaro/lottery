import Foundation

struct SummaryViewModel {
  
  let firstPrize: String
  let secondPrize: String
  let thirdPrize: String
  let forthPrizes: [String]
  let fifthPrizes: [String]
  
  static func empty() -> Self {
    return .init(firstPrize: "", secondPrize: "", thirdPrize: "", forthPrizes: [], fifthPrizes: [])
  }
  
  static func example() -> Self {
    return .init(
      firstPrize: "123456",
      secondPrize: "123456",
      thirdPrize: "123456",
      forthPrizes: ["123456", "234567"],
      fifthPrizes: ["123456", "234567", "345678", "456789", "567890", "678901", "789012", "890123"])
  }
  
}
