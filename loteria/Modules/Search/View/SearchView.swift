import SwiftUI

struct SearchView: View {
  @ObservedObject private var presenter = SearchPresenter()
  
  var body: some View {
    ZStack {
      VStack {
        HStack {
          TextField("Número", text: $presenter.searchText)
            .keyboardType(.numberPad)
            .padding(5.0)
            .disabled(self.presenter.isLoading)
          
          Button(action: {
            self.presenter.userDidSearch()
          }) {
            Image(systemName: "magnifyingglass.circle")
              .foregroundColor(
                presenter.searchDisabled ? Color.gray : Color.black
            )
          }
          .font(Font.system(size: 22.0))
          .disabled(self.presenter.searchDisabled || self.presenter.isLoading)
        }
        .accentColor(.black)
        .padding()
        
        Text(self.presenter.viewModel.message)
        
        Spacer()
      }
      if self.presenter.isLoading {
        Spinner(isAnimating: true)
      }
    }
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView()
  }
}
