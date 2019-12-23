import SwiftUI

struct SummaryStackView: View {
  let viewModel: SummaryViewModel
  
  var body: some View {
    VStack(spacing: 10.0) {
      SummaryCardView(style: .firstPrize, numbers: [viewModel.firstPrize])
      SummaryCardView(style: .secondPrize, numbers: [viewModel.secondPrize])
      SummaryCardView(style: .thirdPrize, numbers: [viewModel.thirdPrize])
      SummaryCardView(style: .forthPrize, numbers: viewModel.forthPrizes)
      SummaryCardView(style: .fifthPrize, numbers: viewModel.fifthPrizes)
    }
    .padding()
  }
}

struct SummaryStackView_Previews: PreviewProvider {
  static var previews: some View {
    SummaryStackView(viewModel: .example())
  }
}
