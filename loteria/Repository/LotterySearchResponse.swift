import Foundation

struct LotterySearchResponse: Decodable {
  
  let timestamp: Int
  let status: LotteryStatus
  let error: Int
  
  let numero: Int
  let premio: Int
  
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
