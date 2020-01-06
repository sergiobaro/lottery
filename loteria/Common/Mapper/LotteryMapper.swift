import Foundation

class LotteryMapper {
  
  func map(status: LotteryStatus) -> String {
    switch status {
      case .notStarted: return "El sorteo no ha comenzado"
      case .started: return "El sorteo ya ha comenzado"
      case .finished, .finishedWithPDF, .finishedOfficial: return "El sorteo ha terminado"
    }
  }
  
  func map(lastUpdate: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(lastUpdate))
    let df = DateFormatter()
    df.dateFormat = "MMM dd, yyyy 'a las' HH:mm"
    
    return "Última actualización: " + df.string(from: date)
  }
  
}
