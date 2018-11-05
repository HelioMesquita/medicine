import Foundation
import PromiseKit

protocol HistoricPresentable: class {
  func configureNavigation()
  func showLoadError(error: Error)
  func loadScreen(historic: [Historic])
}

class HistoricPresenter {

  weak var view: HistoricPresentable?
  let document: PersonalDocumentManager

  init(view: HistoricPresentable, document: PersonalDocumentManager = PersonalDocumentManager()) {
    self.view = view
    self.document = document
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

  func removeDocument() {
    document.remove()
  }

  private func showLoading() -> Guarantee<Void> {
    _ = LoadingViewController()
    return Guarantee<Void>()
  }

  private func performRequest() -> Promise<[Historic]> {
    let link = "http://www.caderemedio.esy.es/controller.php?class=Reserva&action=buscarReserva&cpf=" + document.get()!
    let url = URL(string: link)!
    return APIClient<[Historic]>(url: url).fetch()
  }
}
