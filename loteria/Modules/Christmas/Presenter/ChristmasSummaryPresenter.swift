import Foundation
import SwiftUI
import Combine

class ChristmasSummaryPresenter: ObservableObject {
  
  @Published var viewModel = ChristmasSummaryViewModel.empty()
  @Published var isLoading = false
  
  @Inject("ChristmasLotteryRepository") private var repository: ChristmasLotteryRepository
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
      firstPrize: self.mapper.map(number: response.number1),
      secondPrize: self.mapper.map(number: response.number2),
      thirdPrize: self.mapper.map(number: response.number3),
      forthPrizes: [self.mapper.map(number: response.number4),
                    self.mapper.map(number: response.number5)],
      fifthPrizes: [self.mapper.map(number: response.number6),
                    self.mapper.map(number: response.number7),
                    self.mapper.map(number: response.number8),
                    self.mapper.map(number: response.number9),
                    self.mapper.map(number: response.number10),
                    self.mapper.map(number: response.number11),
                    self.mapper.map(number: response.number12),
                    self.mapper.map(number: response.number13),
      ],
      statusMessage: self.mapper.map(status: response.status),
      lastUpdateMessage: self.mapper.map(lastUpdate: response.timestamp)
    )
  }
}
