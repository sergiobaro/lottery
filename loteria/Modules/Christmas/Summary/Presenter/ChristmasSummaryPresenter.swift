import Foundation
import SwiftUI
import Combine

class ChristmasSummaryPresenter: ObservableObject {
  
  @Published var viewModel = ChristmasSummaryViewModel.empty()
  @Published var isLoading = false
  
  @Inject("ChristmasLotteryRepository") private var repository: ChristmasLotteryRepository
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
  
  // MARK: - Private
  
  private func loadSummary() {
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
  
  private func map(response: ChristmasSummaryResponse?) -> ChristmasSummaryViewModel {
    guard let response = response else {
      return .empty()
    }
    
    return ChristmasSummaryViewModel(
      firstPrize: self.map(number: response.number1),
      secondPrize: self.map(number: response.number2),
      thirdPrize: self.map(number: response.number3),
      forthPrizes: [self.map(number: response.number4), self.map(number: response.number5)],
      fifthPrizes: [self.map(number: response.number6),
                    self.map(number: response.number7),
                    self.map(number: response.number8),
                    self.map(number: response.number9),
                    self.map(number: response.number10),
                    self.map(number: response.number11),
                    self.map(number: response.number12),
                    self.map(number: response.number13),
      ],
      statusMessage: self.map(status: response.status),
      lastUpdateMessage: self.map(lastUpdate: response.timestamp)
    )
  }
  
  private func map(number: Int) -> String {
    return String(format: "%05d", number)
  }
  
  private func map(status: LotteryStatus) -> String {
    switch status {
      case .notStarted: return "El sorteo no ha comenzado"
      case .started: return "El sorteo ya ha comenzado"
      case .finished, .finishedWithPDF, .finishedOfficial: return "El sorteo ha terminado"
    }
  }
  
  private func map(lastUpdate: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(lastUpdate))
    let df = DateFormatter()
    df.timeStyle = .short
    df.dateStyle = .short
    
    return "Última actualización: " + df.string(from: date)
  }
}
