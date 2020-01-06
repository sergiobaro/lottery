import SwiftUI

struct LotteryStatusView: View {
  
  let statusMessage: String
  let lastUpdateMessage: String
  
  var body: some View {
    VStack {
      Divider()
      Text(statusMessage)
        .font(.headline)
      Text(lastUpdateMessage)
        .font(.footnote)
    }
  }
}

struct LotteryStatusView_Previews: PreviewProvider {
  static var previews: some View {
    LotteryStatusView(
      statusMessage: "El sorteo ha terminado",
      lastUpdateMessage: "Última actualización: 12/22/19, 5:04 PM"
    )
  }
}
