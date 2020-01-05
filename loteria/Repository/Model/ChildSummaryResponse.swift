import Foundation
 
struct ChildSummaryResponse: Decodable {
  
  let timestamp: Int
  let status: LotteryStatus
  let error: Int
  
  let prize1: Int
  let prize2: Int
  let prize3: Int
  let extractions2digits: [String]
  let extractions3digits: [String]
  let extractions4digits: [String]
  let repayments: [Int]
  
  enum CodingKeys: String, CodingKey {
    case timestamp
    case status
    case error
    
    case prize1 = "premio1"
    case prize2 = "premio2"
    case prize3 = "premio3"
    case extractions2digits = "extracciones2cifras"
    case extractions3digits = "extracciones3cifras"
    case extractions4digits = "extracciones4cifras"
    case repayments = "reintegros"
  }
  
  static func example() -> Self {
    let response = """
      {
        "timestamp": 1234567890,
        "status": 4,
        "fraseTexto": "Esta es la frase",
        "pdfURL": "http://la.url.com/algun/path/",
        "error": 0,
        "premio1": 79250,
        "premio2": 147,
        "premio3": 548,
        "extracciones4cifras": ["0001", "0002"],
        "extracciones3cifras": ["001", "012", "123", "234", "345", "456",
        "567", "678", "789", "890", "901", "654", "543", "-1"],
        "extracciones2cifras": ["11", "22", "33", "44", "55"],
        "reintegros": [0, 1, 3]
      }
    """
    
    return try! JSONDecoder().decode(Self.self, from: response.data(using: .utf8)!)
  }
  
}
