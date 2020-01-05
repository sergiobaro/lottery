import Foundation

private let ChristmasLotteryUrl = "https://api.elpais.com/ws/LoteriaNavidadPremiados"
private let ChildLotteryUrl = "https://api.elpais.com/ws/LoteriaNinoPremiados"

class LotteryRepositoryBuilder {
  
  static func christmas() -> LotteryRepository<ChristmasSummaryResponse> {
    return LotteryRepository<ChristmasSummaryResponse>(url: ChristmasLotteryUrl)
  }
  
  static func child() -> LotteryRepository<ChildSummaryResponse> {
    return LotteryRepository<ChildSummaryResponse>(url: ChildLotteryUrl)
  }
  
}
