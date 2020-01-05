import Foundation
import SwiftUI
import Combine

class ChristmasSummaryPresenter: ObservableObject {
  
  @Published var viewModel = ChristmasSummaryViewModel.empty()
  @Published var isLoading = false
  
  private let repository = LotteryRepositoryBuilder.christmas()
  
  func viewDidAppear() {
    self.loadSummary()
  }
  
  func userDidRefresh() {
    self.loadSummary()
  }
  
  // MARK: - Private
  
  private func loadSummary() {
    self.isLoading = true
    
    self.repository.fetchSummary { response in
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
        guard let self = self else { return }
        
        if let response = response {
          self.viewModel = self.map(response: response)
        } else {
          self.viewModel = .empty()
        }
        
        self.isLoading = false
      }
    }
  }
  
  private func map(response: ChristmasSummaryResponse) -> ChristmasSummaryViewModel {
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
