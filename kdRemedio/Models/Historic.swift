import Foundation

struct Historic: Decodable {

  let quantity: Int
  let data: String

  enum CodingKeys: String, CodingKey {
    case quantity = "quantidade"
    case data
  }

  func formartDate() -> String? {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd-MM-yyyy"

    if let date = dateFormatterGet.date(from: data) {
      return dateFormatterPrint.string(from: date)
    } else {
      return nil
    }
  }
}
