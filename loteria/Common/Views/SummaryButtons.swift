import SwiftUI

struct SummaryButtons: View {
  
  @State private var showSearch = false
  let refresh: () -> Void
  let sheet: () -> SearchView
  
  var body: some View {
    HStack {
      SystemImageButton(symbolName: "magnifyingglass") {
        self.showSearch = true
      }
      .sheet(isPresented: $showSearch, content: self.sheet)
      Spacer()
      SystemImageButton(symbolName: "arrow.clockwise") {
        self.refresh()
      }
    }
    .accentColor(.black)
    .padding(.top, 15.0)
    .padding([.leading, .trailing], 15.0)
  }
  
}
