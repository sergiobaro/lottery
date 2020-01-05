import SwiftUI

struct SearchResultView: View {
  @Binding var viewModel: SearchViewModel
  
  var body: some View {
    VStack {
      Text(self.viewModel.prizeMessage)
        .font(Font.system(.title))
      Text(self.viewModel.message)
        .font(Font.system(.headline))
        .padding()
    }
  }
}

struct SearchResultView_Previews: PreviewProvider {
  static var previews: some View {
    SearchResultView(viewModel: .constant(
      SearchViewModel(
        prizeMessage: "1.060€ AL DÉCIMO",
        message: "Ha sido premiado con: 2.120€")
      )
    )
  }
}
