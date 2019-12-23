import Foundation

struct LotterySummaryResponse: Decodable {
  
  let timestamp: Int
  let status: LotteryStatus
  let error: Int
  
  let numero1: Int
  let numero2: Int
  let numero3: Int
  let numero4: Int
  let numero5: Int
  let numero6: Int
  let numero7: Int
  let numero8: Int
  let numero9: Int
  let numero10: Int
  let numero11: Int
  let numero12: Int
  let numero13: Int
  
}

extension LotterySummaryResponse {
  
  static func example() -> LotterySummaryResponse {
    let response = """
      {"timestamp":1577017464,"status":2,"numero1":26590,"numero2":10989,"numero3":750,"numero4":41710,"numero5":49797,"numero6":75206,"numero7":6293,"numero8":23059,"numero9":66212,"numero10":74770,"numero11":54527,"numero12":69823,"numero13":81610,"fraseSorteoPDF":"Buscador provisional. Sorteo terminado","fraseListaPDF":"Buscador provisional. Sorteo terminado","listaPDF":"","urlAudio":"","error":0}
    """
    
    return try! JSONDecoder().decode(LotterySummaryResponse.self, from: response.data(using: .utf8)!)
  }
}
