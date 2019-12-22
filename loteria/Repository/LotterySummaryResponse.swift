import Foundation

struct LotterySummaryResponse: Decodable {
  
  let timestamp: Int
  let status: LotteryStatus
  let error: Int
  
  let numero1: Int
  let numero2: Int
  let numero3: Int
  let numero4: Int
  let numero5: Int
  let numero6: Int
  let numero7: Int
  let numero8: Int
  let numero9: Int
  let numero10: Int
  let numero11: Int
  let numero12: Int
  let numero13: Int
  
}
