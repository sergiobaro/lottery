import SwiftUI

struct SummaryButtons: View {
  @State private var showSearch = false
  let refresh: () -> Void
  
  var body: some View {
    HStack {
      self.button(symbol: "magnifyingglass") {
        self.showSearch = true
      }
      .sheet(isPresented: $showSearch) {
        SearchView()
      }
      Spacer()
      self.button(symbol: "arrow.clockwise") {
        self.refresh()
      }
    }
    .accentColor(.black)
    .padding(.top, 15.0)
    .padding([.leading, .trailing], 15.0)
  }
  
  private func button(symbol symbolName: String, action: @escaping () -> ()) -> some View {
    Button(action: action) {
      Image(systemName: symbolName)
        .font(.title)
    }
  }
}
