import Foundation
import Combine

class ChildSummaryPresenter: ObservableObject {
  
  @Published var viewModel = ChildSummaryViewModel.empty()
  @Published var isLoading = false
  
  @Inject("ChildLotteryRepository") private var repository: ChildLotteryRepository
  @Inject private var mapper: LotteryMapper
  private var firstAppear = true
  private var cancellables = Set<AnyCancellable>()
  
  func viewDidAppear() {
    if self.firstAppear {
      self.firstAppear = false
      self.loadSummary()
    }
  }
  
  func userDidRefresh() {
    self.loadSummary()
  }
  
}

private extension ChildSummaryPresenter {

  func loadSummary() {
    self.isLoading = true
    
    self.repository.fetchSummary()
      .delay(for: 0.1, scheduler: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] value in
          guard let self = self else { return }
          switch value {
          case .failure:
            self.viewModel = .empty()
          case .finished:
            self.isLoading = false
          }
        },
        receiveValue: { [weak self] response in
          guard let self = self else { return }
          self.viewModel = self.map(response: response)
        }
      )
      .store(in: &cancellables)
  }
  
  func map(response: ChildSummaryResponse?) -> ChildSummaryViewModel {
    guard let response = response else {
      return .empty()
    }
    
    return .init(
      firstPrize: .init(title: "PRIMER PREMIO", numbers: [self.map(number: response.prize1)], prize: "2.000.000 €"),
      secondPrize: .init(title: "SEGUNDO PREMIO", numbers: [self.map(number: response.prize2)], prize: "750.000 €"),
      thirdPrize: .init(title: "TERCER PREMIO", numbers: [self.map(number: response.prize3)], prize: "250.000 €"),
      endings4digits: .init(title: "TERMINACIONES 4 CIFRAS", numbers: self.map(numbers: response.extractions4digits, length: 4), prize: "3.500 €"),
      endings3digits: .init(title: "TERMINACIONES 3 CIFRAS", numbers: self.map(numbers: response.extractions3digits, length: 3), prize: "100 €"),
      endings2digits: .init(title: "TERMINACIONES 2 CIFRAS", numbers: self.map(numbers: response.extractions2digits, length: 2), prize: "400 €"),
      repayments: .init(title: "TERMINACIONES ESPECIALES", numbers: self.map(numbers: response.repayments, length: 1), prize: "20 €"),
      statusMessage: self.mapper.map(status: response.status),
      lastUpdateMessage: self.mapper.map(lastUpdate: response.timestamp)
    )
  }
  
  func map(numbers: [Int], length: Int = 5) -> [String] {
    return numbers.map { self.map(number: $0, length: length) }
  }
  
  func map(numbers: [String], length: Int = 5) -> [String] {
    return numbers.map { self.map(number: $0, length: length) }
  }
  
  func map(number: String, length: Int = 5) -> String {
    return (number == "-1" ? String(repeating: "-", count: length) : number)
  }
  
  func map(number: Int, length: Int = 5) -> String {
    if number < 0 {
      return String(repeating: "-", count: length)
    }
    return String(format: "%0\(length)d", number)
  }
}
