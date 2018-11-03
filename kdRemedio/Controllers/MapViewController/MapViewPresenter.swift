import Foundation
import PromiseKit

protocol MapViewHandlable: class {
  func configureSearchBar()
  func configureMapView()
  func showAlertError(error: Error)
  func setMapLocation(region: CLLocation)
  func setMapAnnotations(annotations: [MKPointAnnotation])
}

class MapViewPresenter {

  weak var delegate: MapViewHandlable?

  init(delegate: MapViewHandlable) {
    self.delegate = delegate
  }

  func viewDidLoad() {
    delegate?.configureSearchBar()
    delegate?.configureMapView()
    load()
  }

  func load() {
    firstly {
      showLoading()
    }.then {
      when(fulfilled: self.getLocation(), self.makeRequest())
    }.done { location, ubsList in
      ubsList.update(location: location)
      self.delegate?.setMapLocation(region: location)
      self.delegate?.setMapAnnotations(annotations: ubsList.getAnnotations())
      UBSManager.setList(list: ubsList)
    }.catch { error in
      self.delegate?.showAlertError(error: error)
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

  private func makeRequest() -> Promise<UBSList> {
    let url = URL(string: "http://www.caderemedio.esy.es/controller.php?class=Consulta&action=buscarRemedio")!
    return APIClient<UBSList>(url: url).fetch()
  }

  private func getLocation() -> Promise<CLLocation> {
      return CLLocationManager.requestLocation().firstValue
  }
}
