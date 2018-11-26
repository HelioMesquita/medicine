import Foundation
import PromiseKit

protocol ReservationPresentable: class {
  func setScreen()
  func showAlertRequestError(error: Error)
  func showAlertInvalidCPF()
  func showAlertGenericError()
  func showAlertSuccessReservation()
  func showAlerFailReservation()
}

class ReservationPresenter {

  weak var view: ReservationPresentable?

  init(view: ReservationPresentable) {
    self.view = view
  }

  func viewDidLoad() {
    view?.setScreen()
  }

  func handleReservation(cpf: String?, quantity: String, link: Link?) {
    guard let cpf = cpf, cpf.count >= 11 else {
      view?.showAlertInvalidCPF()
      return
    }

    PersonalDocumentManager().save(document: cpf)
    let method = link?.method ?? ""
    var url = link?.url ?? ""
    url = url.replacingOccurrences(of: "{12345678999}", with: cpf)
    url = url.replacingOccurrences(of: "{num}", with: quantity)

    if let urlRequest = URL(string: url), let method = HTTPMethod(rawValue: method) {
      load(url: urlRequest, method: method)
    } else {
      view?.showAlertGenericError()
    }
  }

  private func load(url: URL, method: HTTPMethod) {
    firstly {
      showLoading()
      }.then {
        self.makeRequest(url: url, method: method)
      }.done { reservation in
        if reservation.success {
          self.view?.showAlertSuccessReservation()
        } else {
          self.view?.showAlerFailReservation()
        }
      }.catch { error in
        self.view?.showAlertRequestError(error: error)
      }.finally {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
          NotificationCenter.default.post(name: .removeLoadingViewController, object: nil, userInfo: nil)
        }
    }
  }

  private func showLoading() -> Guarantee<Void> {
    _ = LoadingViewController()
    return Guarantee<Void>()
  }

  private func makeRequest(url: URL, method: HTTPMethod) -> Promise<APIReservation> {
    return APIClient<APIReservation>(url: url, method: method).fetch()
  }
}
