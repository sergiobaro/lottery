import Foundation
import Combine

class SearchPresenter: ObservableObject {
  @Published var searchText = ""
  @Published var amountText = ""
  @Published var searchDisabled = false
  @Published var isLoading = false
  @Published var viewModel = SearchViewModel.empty()
  
  private var repository = LotteryRepositoryBuilder.christmas()
  private var searchTextCancellable: AnyCancellable!
  
  init() {
    let invalidCharacters = CharacterSet(charactersIn: "1234567890").inverted
    
    searchTextCancellable = $searchText.removeDuplicates().sink { text in
      DispatchQueue.main.async {
        let filteredText = text
          .components(separatedBy: invalidCharacters)
          .joined()
          .prefix(Constants.maxDigitsPerNumber)
          .asString()
        self.searchDisabled = filteredText.isEmpty
        self.searchText = filteredText
      }
    }
  }
  
  deinit {
    searchTextCancellable.cancel()
  }
  
  func userDidSearch() {
    self.searchDisabled = true
    self.isLoading = true
    self.viewModel = .empty()
    
    let number = self.searchText.asInt()
    self.repository.search(number: number) { (response) in
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
        guard let self = self else { return }
        
        self.isLoading = false
        self.searchDisabled = false
        if let response = response {
          self.viewModel = self.map(response: response)
        }
      }
    }
  }
}

private extension SearchPresenter {
  
  func map(response: LotterySearchResponse) -> SearchViewModel {
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
