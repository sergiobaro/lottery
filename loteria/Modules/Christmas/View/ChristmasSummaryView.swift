import SwiftUI

struct ChristmasSummaryView: View {
  
  @ObservedObject private var presenter = ChristmasSummaryPresenter()
  
  var body: some View {
    VStack {
      if self.presenter.isLoading {
        Spinner(isAnimating: true)
      } else {
        SummaryButtons() {
          self.presenter.userDidRefresh()
        }
        ChristmasSummaryStackView(viewModel: self.presenter.viewModel)
        LotteryStatusView(
          statusMessage: self.presenter.viewModel.statusMessage,
          lastUpdateMessage: self.presenter.viewModel.lastUpdateMessage
        )
        .padding(.bottom, 10.0)
        Spacer()
      }
    }
    .onAppear {
      self.presenter.viewDidAppear()
    }
  }
}

struct ChristmasSummaryView_Previews: PreviewProvider {
  static var previews: some View {
    ChristmasSummaryView()
  }
}
