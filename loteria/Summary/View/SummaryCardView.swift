import SwiftUI

struct SummaryCardView: View {
  let style: SummaryCardViewStyle
  let numbers: [String]
  
  var body: some View {
    VStack {
      Text(style.title())
        .font(style.titleFont())
        .padding(5.0)
        .frame(maxWidth: .infinity)
        .background(Color(white: 0.9))
      ForEach(0..<self.numberOfRows()) { column in
        HStack {
          ForEach(self.slice(for: column), id: \.self) { number in
            Text(number)
              .font(self.style.numberFont())
          }
        }
        .padding(5.0)
      }
    }
  }
  
  private func numberOfRows() -> Int {
    return self.numbers.count / self.style.numberOfColumns()
  }
  
  private func slice(for column: Int) -> ArraySlice<String> {
    let start = self.style.numberOfColumns() * column
    let end = start + self.style.numberOfColumns()
    return self.numbers[start..<end]
  }
}

enum SummaryCardViewStyle: Int {
  case firstPrize = 1
  case secondPrize
  case thirdPrize
  case forthPrize
  case fifthPrize
  
  func titleFont() -> Font {
    let fonts: [Self: Font] = [
      .firstPrize: Font.system(size: 20.0).weight(.heavy),
      .secondPrize: Font.system(size: 18.0).lowercaseSmallCaps().bold(),
      .thirdPrize: Font.system(size: 16.0).lowercaseSmallCaps().bold(),
      .forthPrize: Font.system(size: 14.0).lowercaseSmallCaps().bold(),
      .fifthPrize: Font.system(size: 14.0).lowercaseSmallCaps()
    ]
    return fonts[self]!
  }
  
  func numberFont() -> Font {
    let fonts: [Self: Font] = [
      .firstPrize: Font.system(size: 38.0).bold(),
      .secondPrize: Font.system(size: 32.0).bold(),
      .thirdPrize: Font.system(size: 28.0).bold(),
      .forthPrize: Font.system(size: 26.0).bold().monospacedDigit(),
      .fifthPrize: Font.system(size: 22.0).monospacedDigit(),
    ]
    return fonts[self]!
  }
  
  func title() -> String {
    if self == .firstPrize {
      return "El Gordo".uppercased()
    }
    
    return "\(self.rawValue)° Premio"
  }
  
  func numberOfColumns() -> Int {
    switch self {
    case .firstPrize, .secondPrize, .thirdPrize: return 1
    case .forthPrize: return 2
    case .fifthPrize: return 4
    }
  }
}

struct SummaryCardView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SummaryCardView(style: .firstPrize, numbers: ["123456"])
      SummaryCardView(style: .secondPrize, numbers: ["123456"])
      SummaryCardView(style: .thirdPrize, numbers: ["123456"])
      SummaryCardView(style: .forthPrize, numbers: ["123456", "234567"])
      SummaryCardView(style: .fifthPrize, numbers: ["123456", "234567", "345678", "456789", "567890", "678901", "789012", "890123"])
    }
    .previewLayout(.fixed(width: 500, height: 200))
  }
}
