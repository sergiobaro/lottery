import Foundation

private let ChristmasLotteryUrl = "https://api.elpais.com/ws/LoteriaNavidadPremiados"
private let ChildLotteryUrl = "https://api.elpais.com/ws/LoteriaNinoPremiados"

class LotteryRepositoryBuilder {
  
  static func christmas() -> LotteryRepository<ChristmasSummaryResponse, LotterySearchResponse> {
    return LotteryRepository<ChristmasSummaryResponse, LotterySearchResponse>(url: ChristmasLotteryUrl)
  }
  
  static func child() -> LotteryRepository<ChildSummaryResponse, LotterySearchResponse> {
    return LotteryRepository<ChildSummaryResponse, LotterySearchResponse>(url: ChildLotteryUrl)
  }
  
}
