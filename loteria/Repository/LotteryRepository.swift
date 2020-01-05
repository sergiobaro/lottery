import Foundation
import Combine

enum LotteryRepositoryError: Error {
  case url(_ description: String)
  case network(_ description: String)
}

class LotteryRepository<
  SummaryResponse: Decodable,
  SearchResponse: Decodable
> {
  
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
  
  func search(number: Int) -> AnyPublisher<SearchResponse?, LotteryRepositoryError> {
    guard let url = self.url(with: String(number)) else {
      return Fail(error: .url("Couldn't build url with number: \(number)")).eraseToAnyPublisher()
    }
    
    return self.session.dataTaskPublisher(for: url)
      .mapError { .network($0.localizedDescription) }
      .map { self.parse(data: $0.data, type: SearchResponse.self) }
      .eraseToAnyPublisher()
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
