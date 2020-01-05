import Foundation

struct ChristmasSummaryResponse: Decodable {
  
  let timestamp: Int
  let status: LotteryStatus
  let error: Int
  
  let number1: Int
  let number2: Int
  let number3: Int
  let number4: Int
  let number5: Int
  let number6: Int
  let number7: Int
  let number8: Int
  let number9: Int
  let number10: Int
  let number11: Int
  let number12: Int
  let number13: Int
  
  enum CodingKeys: String, CodingKey {
    case timestamp
    case status
    case error
    
    case number1 = "numero1"
    case number2 = "numero2"
    case number3 = "numero3"
    case number4 = "numero4"
    case number5 = "numero5"
    case number6 = "numero6"
    case number7 = "numero7"
    case number8 = "numero8"
    case number9 = "numero9"
    case number10 = "numero10"
    case number11 = "numero11"
    case number12 = "numero12"
    case number13 = "numero13"
  }
  
  static func example() -> Self {
    let response = """
      {
        "timestamp": 1577017464,
        "status": 2,
        "numero1": 26590,
        "numero2": 10989,
        "numero3": 750,
        "numero4": 41710,
        "numero5": 49797,
        "numero6": 75206,
        "numero7": 6293,
        "numero8": 23059,
        "numero9": 66212,
        "numero10": 74770,
        "numero11": 54527,
        "numero12": 69823,
        "numero13": 81610,
        "fraseSorteoPDF": "Buscador provisional. Sorteo terminado",
        "fraseListaPDF": "Buscador provisional. Sorteo terminado",
        "listaPDF": "",
        "urlAudio": "",
        "error": 0
      }
    """
    
    return try! JSONDecoder().decode(Self.self, from: response.data(using: .utf8)!)
  }
}
