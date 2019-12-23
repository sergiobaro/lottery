import SwiftUI

struct MainSummaryView: View {
  @ObservedObject var presenter: SummaryPresenter
  
  var body: some View {
    NavigationView {
      if self.presenter.isLoading {
        Spinner(isAnimating: true)
      } else {
        SummaryView(viewModel: self.presenter.viewModel)
      }
    }
    .tabItem {
      Text("Resumen")
    }
    .onAppear {
      self.presenter.viewDidAppear()
    }
  }
}

struct MainSummaryView_Previews: PreviewProvider {
  static var previews: some View {
    MainSummaryView(presenter: SummaryPresenter())
  }
}
