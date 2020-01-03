import Foundation
 
struct ChildSummaryResponse: Decodable {
  
  let timestamp: Int
  let status: LotteryStatus
  let error: Int
  
  let premio1: Int
  let premio2: Int
  let premio3: Int
  let extracciones4cifras: [String]
  let extracciones3cifras: [String]
  let extracciones2cifras: [String]
  let reintegros: [Int]
  
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
