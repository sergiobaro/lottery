import Foundation

// {'numero':NUMERO,'premio':PREMIO_AL_DECIMO,'timestamp':TS_ACTUALIZACION,'status':ESTADO_DEL_SORTEO,'error':0}

struct LotterySearchResponse: Decodable {
  
  let timestamp: Int
  let status: LotteryStatus
  let error: Int
  
  let numero: Int
  let premio: Int
  
}
