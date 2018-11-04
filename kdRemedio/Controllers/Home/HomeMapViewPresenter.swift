import Foundation
import PromiseKit

protocol HomeMapViewPresentable: class {
  func configureSearchBar()

  func configureMapView()
  func setMapLocation(region: CLLocation)
  func setMapAnnotations(annotations: [MKPointAnnotation])

  func showLoadError(error: Error)

  func openHistoric()
  func showCPFInsertAlert()
  func showCPFInvalidAlert()
}

class HomeMapViewPresenter {

  weak var view: HomeMapViewPresentable?

  init(view: HomeMapViewPresentable) {
    self.view = view
  }

  func viewDidLoad() {
    view?.configureSearchBar()
    view?.configureMapView()
    load()
  }

  func load() {
    firstly {
      showLoading()
    }.then {
      when(fulfilled: self.getLocation(), self.performRequest())
    }.done { location, ubsList in
      ubsList.update(location: location)
      self.view?.setMapLocation(region: location)
      self.view?.setMapAnnotations(annotations: ubsList.getAnnotations())
      UBSManager.setList(list: ubsList)
    }.catch { error in
      self.view?.showLoadError(error: error)
    }.finally {
      DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
        NotificationCenter.default.post(name: .removeLoadingViewController, object: nil, userInfo: nil)
      }
    }
  }

  func historicClicked() {
    if UserDefaults.standard.string(forKey: "cpf") != nil {
      view?.openHistoric()
    } else {
      view?.showCPFInsertAlert()
    }
  }

  func handleCPF(cpf: String) {
    if cpf.count >= 10 {
      UserDefaults.standard.set(cpf, forKey: "cpf")
      view?.openHistoric()
    } else {
      view?.showCPFInvalidAlert()
    }
  }

  private func showLoading() -> Guarantee<Void> {
    _ = LoadingViewController()
    return Guarantee<Void>()
  }

  private func performRequest() -> Promise<UBSList> {
    let url = URL(string: "http://www.caderemedio.esy.es/controller.php?class=Consulta&action=buscarRemedio")!
    return APIClient<UBSList>(url: url).fetch()
  }

  private func getLocation() -> Promise<CLLocation> {
      return CLLocationManager.requestLocation().firstValue
  }
}
