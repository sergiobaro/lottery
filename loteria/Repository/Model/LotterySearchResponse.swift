import Foundation

struct LotterySearchResponse: Decodable {
  
  let timestamp: Int
  let status: LotteryStatus
  let error: Int
  
  let number: Int
  let prize: Int
  
  enum CodingKeys: String, CodingKey {
    case timestamp
    case status
    case error
    case number = "numero"
    case prize = "premio"
  }
  
  static func example() -> Self {
    let response = """
      {
        "numero": 0,
        "premio": 0,
        "timestamp": 123456789,
        "status": 0,
        "error": 0
      }
    """
      
    return try! JSONDecoder().decode(Self.self, from: response.data(using: .utf8)!)
  }
  
}
