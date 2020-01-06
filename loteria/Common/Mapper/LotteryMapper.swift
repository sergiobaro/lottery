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
  
  func map(numbers: [Int], length: Int = 5) -> [String] {
    return numbers.map { self.map(number: $0, length: length) }
  }
  
  func map(numbers: [String], length: Int = 5) -> [String] {
    return numbers.map { self.map(number: $0, length: length) }
  }
  
  func map(number: String, length: Int = 5) -> String {
    return (number == "-1" ? String(repeating: "-", count: length) : number)
  }
  
  func map(number: Int, length: Int = 5) -> String {
    if number < 0 {
      return String(repeating: "-", count: length)
    }
    return String(format: "%0\(length)d", number)
  }
}
