import SwiftUI
import UIKit

struct Spinner: UIViewRepresentable {
  @State var isAnimating: Bool = false
  
  func makeUIView(context: UIViewRepresentableContext<Spinner>) -> UIActivityIndicatorView {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.hidesWhenStopped = true
    spinner.color = .black
    
    return spinner
  }
  
  func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Spinner>) {
    if self.isAnimating {
      uiView.startAnimating()
    } else {
      uiView.stopAnimating()
    }
  }
}
