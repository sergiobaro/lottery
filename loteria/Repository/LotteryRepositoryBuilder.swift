import Foundation

private let ChristmasLotteryUrl = "https://api.elpais.com/ws/LoteriaNavidadPremiados"
private let ChildLotteryUrl = "https://api.elpais.com/ws/LoteriaNinoPremiados"

typealias ChristmasLotteryRepository = LotteryRepository<ChristmasSummaryResponse>
typealias ChildLotteryRepository = LotteryRepository<ChildSummaryResponse>

class LotteryRepositoryBuilder {
  
  static func christmas() -> ChristmasLotteryRepository {
    return ChristmasLotteryRepository(url: ChristmasLotteryUrl)
  }
  
  static func child() -> ChildLotteryRepository {
    return ChildLotteryRepository(url: ChildLotteryUrl)
  }
  
}
