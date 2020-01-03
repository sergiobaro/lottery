import SwiftUI

struct AppView: View {
  var body: some View {
    TabView {
      ChristmasSummaryView()
        .tabItem {
          Text("Navidad")
        }
      
      ChildSummaryView()
        .tabItem {
          Text("El Niño")
        }
    }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
