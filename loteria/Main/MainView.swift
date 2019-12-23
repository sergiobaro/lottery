import SwiftUI

struct MainView: View {
  var body: some View {
    TabView {
      MainSummaryView(presenter: SummaryPresenter())
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
