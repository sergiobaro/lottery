import Foundation
import Combine

class ChildSummaryPresenter: ObservableObject {
  
  @Published var viewModel = ChildSummaryViewModel.empty()
  @Published var isLoading = false
  
  @Inject("ChildLotteryRepository") private var repository: ChildLotteryRepository
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
      .receive(on: DispatchQueue.main)
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
    
    return .init()
  }
}
