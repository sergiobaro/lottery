import SwiftUI

struct SearchView: View {
  @ObservedObject var presenter: SearchPresenter
  
  var body: some View {
    ZStack {
      VStack {
        SearchFormView(
          searchText: $presenter.searchText,
          amountText: $presenter.amountText,
          disabled: $presenter.searchDisabled) {
            self.presenter.userDidSearch()
        }
        
        Divider()
          .padding()
        
        SearchResultView(viewModel: $presenter.viewModel)
        
        Spacer()
      }
      .accentColor(.black)
      .padding()
      
      if self.presenter.isLoading {
        Spinner(isAnimating: true)
      }
    }
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView(presenter: SearchPresenter(repository: LotteryRepositoryBuilder.christmas()))
  }
}
