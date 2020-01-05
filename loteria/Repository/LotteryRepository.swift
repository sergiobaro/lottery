import Foundation
import Combine

enum LotteryRepositoryError: Error {
  case url(_ description: String)
  case network(_ description: String)
}

class LotteryRepository<SummaryResponse: Decodable> {
  
  private let url: String
  private let session = URLSession.shared
  
  init(url: String) {
    self.url = url
  }
  
  func fetchSummary() -> AnyPublisher<SummaryResponse?, LotteryRepositoryError> {
    guard let url = self.url(with: "resumen") else {
      return Fail(error: .url("Couldn't build url")).eraseToAnyPublisher()
    }
    
    return self.session.dataTaskPublisher(for: url)
      .mapError { .network($0.localizedDescription) }
      .map { self.parse(data: $0.data, type: SummaryResponse.self) }
      .eraseToAnyPublisher()
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
  
}

private extension LotteryRepository {
  
  private func url(with number: String) -> URL? {
    var components = URLComponents(string: self.url)
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
