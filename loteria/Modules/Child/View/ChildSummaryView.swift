import SwiftUI

struct ChildSummaryView: View {
  
  @ObservedObject var presenter = ChildSummaryPresenter()
  
  var body: some View {
    ScrollView {
      if self.presenter.isLoading {
        Spinner(isAnimating: true)
      } else {
        SummaryButtons() {
          self.presenter.userDidRefresh()
        }
        ChildStackSummaryView(viewModel: self.presenter.viewModel)
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
