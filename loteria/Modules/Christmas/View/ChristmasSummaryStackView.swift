import SwiftUI

struct ChristmasSummaryStackView: View {
  
  let viewModel: ChristmasSummaryViewModel
  
  var body: some View {
    VStack(spacing: 10.0) {
      ChristmasSummaryCardView(style: .firstPrize, numbers: [viewModel.firstPrize])
      ChristmasSummaryCardView(style: .secondPrize, numbers: [viewModel.secondPrize])
      ChristmasSummaryCardView(style: .thirdPrize, numbers: [viewModel.thirdPrize])
      ChristmasSummaryCardView(style: .forthPrize, numbers: viewModel.forthPrizes)
      ChristmasSummaryCardView(style: .fifthPrize, numbers: viewModel.fifthPrizes)
    }
    .padding(10.0)
  }
}

struct ChristmasSummaryStackView_Previews: PreviewProvider {
  static var previews: some View {
    ChristmasSummaryStackView(viewModel: .example())
  }
}
