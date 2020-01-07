import SwiftUI

struct SystemImageButton: View {
  
  let symbolName: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Image(systemName: symbolName)
        .font(.title)
    }
  }
}
