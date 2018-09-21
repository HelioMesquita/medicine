import Foundation
import PromiseKit
import Alamofire

class APIClient<T> where T: Decodable {
  let url: URL

  init(url: URL) {
    self.url = url
  }

  func fetch(parameters: [String: Any]) -> Promise<T> {
    return Alamofire.request(url, parameters: parameters).responseDecodable(T.self)
  }
}
