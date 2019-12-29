import SwiftUI

struct SearchFormView: View {
  @Binding var searchText: String
  @Binding var amountText: String
  @Binding var disabled: Bool
  let action: () -> ()
  
  var body: some View {
    VStack {
      HStack {
        Text("Número:")
        TextField("00000", text: $searchText)
          .keyboardType(.numberPad)
          .padding(5.0)
      }
      
      HStack {
        Text("Cantidad jugada (€):")
        TextField("20", text: $amountText)
          .keyboardType(.numberPad)
          .padding(5.0)
      }
      
      Button(action: self.action) {
        Text("Comprobar")
          .font(Font.system(size: 22.0))
          .padding([.top, .bottom], 5.0)
          .padding([.leading, .trailing], 12.0)
          .foregroundColor(Color.white)
      }
      .background(self.disabled ? Color.gray : Color.black )
      .cornerRadius(5.0)
      .padding(.top, 20.0)
      .disabled(self.disabled)
    }
  }
}

struct SearchFormView_Previews: PreviewProvider {
  static var previews: some View {
    SearchFormView(
      searchText: .constant(""),
      amountText: .constant(""),
      disabled: .constant(false),
      action: {})
  }
}
