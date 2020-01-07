import SwiftUI

struct ChildSummaryView: View {
  
  @ObservedObject var presenter = ChildSummaryPresenter()
  
  var body: some View {
    VStack {
      if self.presenter.isLoading {
        Spinner(isAnimating: true)
      } else {
        ScrollView {
          SummaryButtons(
            refresh: { self.presenter.userDidRefresh() },
            sheet: { SearchView(presenter: SearchPresenter(repository: LotteryRepositoryBuilder.child())) }
          )
          ChildStackSummaryView(viewModel: self.presenter.viewModel)
          LotteryStatusView(
            statusMessage: self.presenter.viewModel.statusMessage,
            lastUpdateMessage: self.presenter.viewModel.lastUpdateMessage
          )
          .padding(.bottom, 10.0)
        }
      }
    }
    .onAppear {
      self.presenter.viewDidAppear()
    }
  }
}

struct ChildSummaryView_Previews: PreviewProvider {
  static var previews: some View {
    ChildSummaryView()
  }
}
