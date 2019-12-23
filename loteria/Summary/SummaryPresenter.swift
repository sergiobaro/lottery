import Foundation
import SwiftUI
import Combine

class SummaryPresenter: ObservableObject {
  
  @Published var viewModel: SummaryViewModel = .empty()
  @Published var isLoading: Bool = false
  
  private let repository = LotteryRepository()
  
  func viewDidAppear() {
    self.isLoading = true
    repository.fetchSummary { response in
      DispatchQueue.main.async { [weak self] in
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
  
  // MARK: - Private
  
  private func map(response: LotterySummaryResponse) -> SummaryViewModel {
    return SummaryViewModel(
      firstPrize: self.map(number: response.numero1),
      secondPrize: self.map(number: response.numero2),
      thirdPrize: self.map(number: response.numero3),
      forthPrizes: [self.map(number: response.numero4), self.map(number: response.numero5)],
      fifthPrizes: [self.map(number: response.numero6),
                    self.map(number: response.numero7),
                    self.map(number: response.numero8),
                    self.map(number: response.numero9),
                    self.map(number: response.numero10),
                    self.map(number: response.numero11),
                    self.map(number: response.numero12),
                    self.map(number: response.numero13),
      ]
    )
  }
  
  private func map(number: Int) -> String {
    return String(format: "%05d", number)
  }
  
}
