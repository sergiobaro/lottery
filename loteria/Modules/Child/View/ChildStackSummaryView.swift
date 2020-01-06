import SwiftUI

struct ChildStackSummaryView: View {
  
  let viewModel: ChildSummaryViewModel
  
  var body: some View {
    VStack {
      ChildCardView(viewModel: viewModel.firstPrize)
        .padding()
      HStack {
        ChildCardView(viewModel: viewModel.secondPrize)
          .padding(.trailing, 10.0)
        ChildCardView(viewModel: viewModel.thirdPrize)
          .padding(.leading, 10.0)
      }
      .padding()
      .padding(.top, -10)
      ChildCardView(viewModel: viewModel.endings4digits)
        .padding()
        .padding(.top, -10)
      ChildCardView(viewModel: viewModel.endings3digits)
        .padding()
        .padding(.top, -10)
      ChildCardView(viewModel: viewModel.endings2digits)
        .padding()
        .padding(.top, -10)
      ChildCardView(viewModel: viewModel.repayments)
        .padding()
        .padding(.top, -10)
    }
  }
}

struct ChildStackSummaryView_Previews: PreviewProvider {
  static var previews: some View {
    ChildStackSummaryView(viewModel: .example())
  }
}
