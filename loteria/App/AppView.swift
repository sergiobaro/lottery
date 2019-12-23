import SwiftUI

struct AppView: View {
  var body: some View {
    SummaryView(presenter: SummaryPresenter())
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
