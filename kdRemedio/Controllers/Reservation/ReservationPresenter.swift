import Foundation
import PromiseKit

protocol ReservationPresentable: class {
  func setScreen()
  func showRequestError(error: Error)
  func showCPFInvalidAlert()
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
    if let cpf = cpf, cpf.count == 11, var url = link?.url, let method = link?.method {
      url = url.replacingOccurrences(of: "{12345678999}", with: cpf)
      url = url.replacingOccurrences(of: "{num}", with: quantity)
//      APIClient(url: URL(string: url)!, method: HTTPMethod(rawValue: method)!)

    } else {
      view?.showCPFInvalidAlert()
    }

//.then {
//      when(fulfilled: self.getLocation(), self.makeRequest())
//    }.done { location, ubsList in
//      ubsList.update(location: location)
//      UBSManager.setList(list: ubsList)
//    }.catch { error in
//      self.delegate?.showAlertError(error: error)
//    }.finally {
//      DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
//        NotificationCenter.default.post(name: .removeLoadingViewController, object: nil, userInfo: nil)
//      }
//    }
  }

  private func showLoading() -> Guarantee<Void> {
    _ = LoadingViewController()
    return Guarantee<Void>()
  }
//
//  private func makeRequest() -> Promise<UBSList> {
//    return APIClient<UBSList>(url: url).fetch()
//  }

//  func historicClicked() {
//    if UserDefaults.standard.string(forKey: "cpf") != nil {
//      view?.openHistoric()
//    } else {
//      view?.showCPFInsertAlert()
//    }
//  }
//
//  func handleCPF(cpf: String) {
//    if cpf.count == 11 {
//      UserDefaults.standard.set(cpf, forKey: "cpf")
//      view?.openHistoric()
//    } else {
//      view?.showCPFInvalidAlert()
//    }
//  }
}
