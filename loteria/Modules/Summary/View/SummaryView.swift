import SwiftUI

struct SummaryView: View {
  @ObservedObject var presenter: SummaryPresenter
  
  var body: some View {
    VStack {
      if self.presenter.isLoading {
        Spinner(isAnimating: true)
      } else {
        SummaryStackView(viewModel: self.presenter.viewModel)
          .padding(.top, 30.0)
        Spacer()
      }
    }
    .onAppear {
      self.presenter.viewDidAppear()
    }
  }
}

struct SummaryView_Previews: PreviewProvider {
  static var previews: some View {
    SummaryView(presenter: SummaryPresenter())
  }
}
