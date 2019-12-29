import Foundation
import Combine

class SearchPresenter: ObservableObject {
  @Published var searchText = ""
  @Published var searchDisabled = true
  @Published var isLoading = false
  @Published var viewModel = SearchViewModel.empty()
  
  private var repository = LotteryRepository()
  private var searchTextCancellable: AnyCancellable!
  
  init() {
    let invalidCharacters = CharacterSet(charactersIn: "1234567890").inverted
    
    searchTextCancellable = $searchText.removeDuplicates().sink { text in
      DispatchQueue.main.async {
        let filteredText = text.components(separatedBy: invalidCharacters).joined().prefix(5).asString()
        self.searchDisabled = filteredText.isEmpty
        self.searchText = filteredText
      }
    }
  }
  
  deinit {
    searchTextCancellable.cancel()
  }
  
  func userDidSearch() {
    self.isLoading = true
    
    let number = self.searchText.asInt()
    self.repository.search(number: number) { (response) in
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        
        self.isLoading = false
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
      message: self.mapMessage(prize: response.premio)
    )
  }
  
  func mapMessage(prize: Int) -> String {
    if prize == 0 {
      return "NO HA SIDO PREMIADO"
    }
    
    let nf = NumberFormatter()
    nf.groupingSeparator = "."
    nf.numberStyle = .decimal

    let number = nf.string(for: prize)!
    return "\(number)€ AL DÉCIMO"
  }
}
