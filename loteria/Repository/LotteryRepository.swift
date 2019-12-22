import Foundation

fileprivate let ChristmasLottery = "https://api.elpais.com/ws/LoteriaNavidadPremiados"
fileprivate let ChildrenLottery = "http://api.elpais.com/ws/LoteriaNinoPremiados"

class LotteryRepository {
  
  func fetchSummary(completion: @escaping (LotterySummaryResponse?) -> ()) {
    guard var components = URLComponents(string: ChristmasLottery) else {
      completion(nil)
      return
    }
    
    components.queryItems = [
      URLQueryItem(name: "n", value: "resumen")
    ]
    
    guard let url = components.url else {
      completion(nil)
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = self.trimResponse(data: data) else {
        completion(nil)
        return
      }
      
      do {
        let summaryResponse = try JSONDecoder().decode(LotterySummaryResponse.self, from: data)
        completion(summaryResponse)
      } catch {
        completion(nil)
      }
    }
    
    task.resume()
  }
  
  func search(number: String) {
    
  }
  
  // MARK: - Private
  
  private func trimResponse(data: Data?) -> Data? {
    return data.flatMap({ data -> String? in
        return String(data: data, encoding: .utf8)?.components(separatedBy: "=").last
      })
      .flatMap({ string -> Data? in
        return string.data(using: .utf8)
      })
  }
  
}
