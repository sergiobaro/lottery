import SwiftUI

struct ChildSummaryView: View {
  
  @ObservedObject var presenter = ChildSummaryPresenter()
  
  var body: some View {
    VStack {
      if self.presenter.isLoading {
        Spinner(isAnimating: true)
      } else {
        SummaryButtons() {
          self.presenter.userDidRefresh()
        }
//        ChristmasSummaryStackView(viewModel: self.presenter.viewModel)
        Spacer()
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
