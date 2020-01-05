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
    repository.fetchSummary { response in
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
      ]
    )
  }
  
  private func map(number: Int) -> String {
    return String(format: "%05d", number)
  }
  
}
