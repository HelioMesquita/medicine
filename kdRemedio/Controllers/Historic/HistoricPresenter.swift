import Foundation
import PromiseKit

protocol HistoricPresentable: class {
  func configureNavigation()
  func showLoadError(error: Error)
  func loadScreen(historic: [Historic])
}

class HistoricPresenter {

  weak var view: HistoricPresentable?

  init(view: HistoricPresentable) {
    self.view = view
  }

  func viewDidLoad() {
    view?.configureNavigation()
    load()
  }

  func load() {
    firstly {
      showLoading()
    }.then {
      self.performRequest()
    }.done { historic in
      self.view?.loadScreen(historic: historic)
    }.catch { error in
      self.view?.showLoadError(error: error)
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

  private func performRequest() -> Promise<[Historic]> {
    let cpf = UserDefaults.standard.string(forKey: "cpf")!
    let link = "http://www.caderemedio.esy.es/controller.php?class=Reserva&action=buscarReserva&cpf=" + cpf
    let url = URL(string: link)!
    return APIClient<[Historic]>(url: url).fetch()
  }
}
