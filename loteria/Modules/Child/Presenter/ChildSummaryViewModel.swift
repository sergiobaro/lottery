import Foundation

struct ChildPrizeViewModel {
  let title: String
  let numbers: [String]
  let prize: String
  
  static func example() -> Self {
    return .init(
      title: "PRIMER PREMIO",
      numbers: ["54321"],
      prize: "2.000.000 €"
    )
  }
}

struct ChildSummaryViewModel {
  
  let firstPrize: ChildPrizeViewModel
  let secondPrize: ChildPrizeViewModel
  let thirdPrize: ChildPrizeViewModel
  let endings4digits: ChildPrizeViewModel
  let endings3digits: ChildPrizeViewModel
  let endings2digits: ChildPrizeViewModel
  let repayments: ChildPrizeViewModel
  
  static func empty() -> Self {
    return .init(
      firstPrize: .init(title: "", numbers: [], prize: ""),
      secondPrize: .init(title: "", numbers: [], prize: ""),
      thirdPrize: .init(title: "", numbers: [], prize: ""),
      endings4digits: .init(title: "", numbers: [], prize: ""),
      endings3digits: .init(title: "", numbers: [], prize: ""),
      endings2digits: .init(title: "", numbers: [], prize: ""),
      repayments: .init(title: "", numbers: [], prize: "")
    )
  }
  
  static func example() -> Self {
    return .init(
      firstPrize: .init(title: "PRIMER PREMIO", numbers: ["05685"], prize: "2.000.000 €"),
      secondPrize: .init(title: "SEGUNDO PREMIO", numbers: ["18442"], prize: "750.000 €"),
      thirdPrize: .init(title: "TERCER PREMIO", numbers: ["23282"], prize: "250.000 €"),
      endings4digits: .init(title: "TERMINACIONES 4 CIFRAS", numbers: ["3297", "3905"], prize: "3.500 €"),
      endings3digits: .init(title: "TERMINACIONES 3 CIFRAS", numbers: ["245", "647", "932", "172", "586", "446", "200", "028", "149", "154", "397", "515", "129", "791"], prize: "1.000 €"),
      endings2digits: .init(title: "TERMINACIONES 2 CIFRAS", numbers: ["58", "18", "00", "78", "95"], prize: "400 €"),
      repayments: .init(title: "EXTRACCIONES ESPECIALES", numbers: ["8", "0"], prize: "")
    )
  }
}
