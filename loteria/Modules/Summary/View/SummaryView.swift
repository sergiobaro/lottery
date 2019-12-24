import SwiftUI

struct SummaryView: View {
  @ObservedObject var presenter: SummaryPresenter
  
  var body: some View {
    ZStack {
      VStack {
        HStack {
          Spacer()
          Button(action: {
            self.presenter.userDidRefresh()
          }) {
            Image(systemName: "arrow.clockwise")
              .font(.title)
              .foregroundColor(Color.black)
          }
          .padding()
          .disabled(self.presenter.isLoading)
        }
        if !self.presenter.isLoading {
          SummaryStackView(viewModel: self.presenter.viewModel)
        }
        Spacer()
      }
      if self.presenter.isLoading {
        Spinner(isAnimating: true)
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
