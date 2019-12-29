import SwiftUI

struct SummaryView: View {
  @ObservedObject private var presenter = SummaryPresenter()
  @State private var showSearch = false
  
  var body: some View {
    ZStack {
      VStack {
        HStack {
          self.button(symbol: "magnifyingglass") {
            self.showSearch = true
          }
          .sheet(isPresented: $showSearch) {
            SearchView()
          }
          Spacer()
          self.button(symbol: "arrow.clockwise") {
            self.presenter.userDidRefresh()
          }
        }
        .accentColor(
          self.presenter.isLoading ? .gray : .black
        )
        .padding()
        
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
  
  private func button(symbol symbolName: String, action: @escaping () -> ()) -> some View {
    Button(action: action) {
      Image(systemName: symbolName)
        .font(.title)
    }
    .disabled(self.presenter.isLoading)
  }
}

struct SummaryView_Previews: PreviewProvider {
  static var previews: some View {
    SummaryView()
  }
}
