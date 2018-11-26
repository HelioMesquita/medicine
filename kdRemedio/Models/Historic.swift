import Foundation

struct Historic: Decodable {

  let amount: Int
  let date: String
  let pharmacy: String
  let medicine: String

  enum CodingKeys: String, CodingKey {
    case amount = "quantidade"
    case pharmacy = "nome_farmacia"
    case medicine = "nome_remedio"
    case date = "data"
  }

  func formartDate() -> String? {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd-MM-yyyy"

    if let date = dateFormatterGet.date(from: date) {
      return dateFormatterPrint.string(from: date)
    } else {
      return nil
    }
  }
}
