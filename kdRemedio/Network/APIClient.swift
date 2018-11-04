import Alamofire
import Foundation
import PromiseKit

class APIClient<T> where T: Decodable {
  let url: URL
  let method: HTTPMethod

  init(url: URL, method: HTTPMethod = .get) {
    self.url = url
    self.method = method
  }

  func fetch(parameters: [String: Any]? = nil) -> Promise<T> {
    return Alamofire.request(url, method: method, parameters: parameters).responseDecodable(T.self)
  }
}
