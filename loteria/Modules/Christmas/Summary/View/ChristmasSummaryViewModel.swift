import Foundation

struct ChristmasSummaryViewModel {
  
  let firstPrize: String
  let secondPrize: String
  let thirdPrize: String
  let forthPrizes: [String]
  let fifthPrizes: [String]
  
  let statusMessage: String
  let lastUpdateMessage: String
  
  static func empty() -> Self {
    return Self(
      firstPrize: "",
      secondPrize: "",
      thirdPrize: "",
      forthPrizes: [],
      fifthPrizes: [],
      statusMessage: "",
      lastUpdateMessage: ""
    )
  }
  
  static func example() -> Self {
    return Self(
      firstPrize: "123456",
      secondPrize: "123456",
      thirdPrize: "123456",
      forthPrizes: ["123456", "234567"],
      fifthPrizes: ["123456", "234567", "345678", "456789", "567890", "678901", "789012", "890123"],
      statusMessage: "El sorteo ha terminado",
      lastUpdateMessage: "Última actualización: 12/22/19, 5:04 PM"
    )
  }
  
}
