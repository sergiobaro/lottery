import Foundation
import Combine

class SearchPresenter: ObservableObject {

  struct Constants {
    static let amountPerTenth = 20
    static let maxDigitsPerNumber = 5
  }
  
  @Published var searchText = ""
  @Published var amountText = ""
  @Published var searchDisabled = false
  @Published var isLoading = false
  @Published var viewModel = SearchViewModel.empty()
  
  private var repository: SearchLotteryRepository
  private var cancellables = Set<AnyCancellable>()
  
  init(repository: SearchLotteryRepository) {
    self.repository = repository
    
    let invalidCharacters = CharacterSet(charactersIn: "1234567890").inverted
    
    $searchText
      .removeDuplicates()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] text in
        guard let self = self else { return }
        
        let filteredText = text
          .components(separatedBy: invalidCharacters)
          .joined()
          .prefix(Constants.maxDigitsPerNumber)
          .asString()
        self.searchDisabled = filteredText.isEmpty
        self.searchText = filteredText
      }
      .store(in: &cancellables)
  }
  
  func userDidSearch() {
    self.searchDisabled = true
    self.isLoading = true
    self.viewModel = .empty()
    
    let number = self.searchText.asInt()
    
    self.repository.search(number: number)
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] value in
          guard let self = self else { return }
          switch value {
          case .failure:
            self.viewModel = .empty()
          case .finished:
            self.searchDisabled = false
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
}

private extension SearchPresenter {
  
  func map(response: LotterySearchResponse?) -> SearchViewModel {
    guard let response = response else {
      return .empty()
    }
    
    return SearchViewModel(
      prizeMessage: self.mapPrizeMessage(prize: response.prize),
      message: self.mapMessage(
        prize: response.prize,
        amount: Int(self.amountText) ?? Constants.amountPerTenth)
    )
  }
  
  func mapPrizeMessage(prize: Int) -> String {
    guard prize > 0 else {
      return "NO HA SIDO PREMIADO"
    }
    
    let number = self.map(number: prize)
    return "\(number)€ AL DÉCIMO"
  }
  
  func map(number: Int) -> String {
    let nf = NumberFormatter()
    nf.groupingSeparator = "."
    nf.numberStyle = .decimal

    return nf.string(for: number)!
  }
  
  func mapMessage(prize: Int, amount: Int) -> String {
    guard prize > 0 else {
      return ""
    }
    
    let win = (prize/Constants.amountPerTenth) * amount
    
    let number = self.map(number: win)
    return "Has sido premiado con: \(number)€"
  }
}
