import Foundation

enum LotteryStatus: Int, Codable {
  case notStarted = 0 // El sorteo no ha comenzado aún
  case started = 1 // El sorteo ha empezado
  case finished = 2 // El sorteo ha terminado
  case finishedWithPDF = 3 // El sorteo ha terminado y existe una lista oficial en PDF
  case finishedOfficial = 4 // El sorteo ha terminado y la lista de números y premios está basada en la oficial
}
