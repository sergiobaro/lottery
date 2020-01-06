import SwiftUI

struct ChildCardView: View {
  let viewModel: ChildPrizeViewModel
  
  var body: some View {
    VStack {
      Text(viewModel.title)
        .font(.caption)
        .bold()
      Divider()
        .background(Color.gray)
        .padding(-5)
      HStack {
        Spacer()
        ForEach(viewModel.numbers.prefix(6), id: \.self) { number in
          Group {
            Text(number)
              .font(.title)
              .padding([.top, .bottom], -5)
            Spacer()
          }
        }
      }
      .padding(.bottom, 5)
      if !viewModel.prize.isEmpty {
        Divider()
          .background(Color.gray)
          .padding([.leading, .trailing], -5)
        Text(viewModel.prize)
          .foregroundColor(.blue)
          .font(.footnote)
          .padding(.top, -5)
      }
    }
    .padding(5.0)
    .overlay(
      RoundedRectangle(cornerRadius: 2)
      .stroke(Color.gray, lineWidth: 1.0)
    )
  }
}

struct ChildCardView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ChildCardView(viewModel: ChildSummaryViewModel.example().firstPrize)
      ChildCardView(viewModel: ChildSummaryViewModel.example().secondPrize)
      ChildCardView(viewModel: ChildSummaryViewModel.example().thirdPrize)
      ChildCardView(viewModel: ChildSummaryViewModel.example().endings4digits)
      ChildCardView(viewModel: ChildSummaryViewModel.example().endings3digits)
      ChildCardView(viewModel: ChildSummaryViewModel.example().endings2digits)
      ChildCardView(viewModel: ChildSummaryViewModel.example().repayments)
    }
    .previewLayout(.fixed(width: 500, height: 200))
  }
}
