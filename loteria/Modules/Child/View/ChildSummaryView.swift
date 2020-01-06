import SwiftUI

struct ChildSummaryView: View {
  
  @ObservedObject var presenter = ChildSummaryPresenter()
  
  var body: some View {
    VStack {
      if self.presenter.isLoading {
        Spinner(isAnimating: true)
      } else {
        ScrollView {
          SummaryButtons() {
            self.presenter.userDidRefresh()
          }
          ChildStackSummaryView(viewModel: self.presenter.viewModel)
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
