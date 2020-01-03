import SwiftUI

struct ChristmasSummaryView: View {
  @ObservedObject private var presenter = ChristmasSummaryPresenter()
  @State private var showSearch = false
  
  var body: some View {
    ZStack {
      VStack {
        buttons
        
        if !self.presenter.isLoading {
          ChristmasSummaryStackView(viewModel: self.presenter.viewModel)
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
  
  private var buttons: some View {
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
  }
  
  private func button(symbol symbolName: String, action: @escaping () -> ()) -> some View {
    Button(action: action) {
      Image(systemName: symbolName)
        .font(.title)
    }
    .disabled(self.presenter.isLoading)
  }
}

struct ChristmasSummaryView_Previews: PreviewProvider {
  static var previews: some View {
    ChristmasSummaryView()
  }
}
