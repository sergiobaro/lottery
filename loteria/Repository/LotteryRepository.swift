import Foundation

fileprivate let ChristmasLottery = "https://api.elpais.com/ws/LoteriaNavidadPremiados"
fileprivate let ChildrenLottery = "http://api.elpais.com/ws/LoteriaNinoPremiados"

class LotteryRepository {
  
  func fetchSummary(completion: @escaping (LotterySummaryResponse?) -> ()) {
    guard let url = self.url(with: "resumen") else {
      completion(nil)
      return
    }
    
    self.perform(url: url, responseType: LotterySummaryResponse.self) { (response) in
      completion(response)
    }
  }
  
  func search(number: Int, completion: @escaping (LotterySearchResponse?) -> ()) {
    guard let url = self.url(with: String(number)) else {
      completion(nil)
      return
    }
    
    self.perform(url: url, responseType: LotterySearchResponse.self) { (response) in
      completion(response)
    }
  }
  
  // MARK: - Private
  
  private func url(with number: String) -> URL? {
    var components = URLComponents(string: ChristmasLottery)
    components?.queryItems = [
      URLQueryItem(name: "n", value: number)
    ]
    
    return components?.url
  }
  
  private func perform<T: Decodable>(url: URL, responseType: T.Type, completion: @escaping (T?) -> ()) {
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      let response = self.parse(data: data, type: responseType)
      completion(response)
    }
    task.resume()
  }
  
  private func parse<T: Decodable>(data: Data?, type: T.Type) -> T? {
    return data
      .flatMap({ data -> String? in
        return String(data: data, encoding: .utf8)?.components(separatedBy: "=").last
      })
      .flatMap({ string -> Data? in
        return string.data(using: .utf8)
      })
      .flatMap({ data -> T? in
        try? JSONDecoder().decode(type, from: data)
      })
  }
}
