import Foundation
import PromiseKit

protocol MapViewHandlable: class {
  func configureSearchBar()
  func configureMapView()
  func showAlertError(error: Error)
  func setMapLocation(region: CLLocation)
  func setMapAnnotations(annotations: [MKAnnotation])
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

  private func load() {
    _ = LoadingViewController()
    firstly {
      CLLocationManager.requestLocation()
    }.firstValue.get { region in
      self.delegate?.setMapLocation(region: region)
    }.then { location in
      self.makeRequest(location: location)
    }.done { ubslist in
      self.delegate?.setMapAnnotations(annotations: ubslist.getAnnotations())
      UbsManager.setList(list: ubslist)
    }.catch { error in
      self.delegate?.showAlertError(error: error)
    }.finally {
      NotificationCenter.default.post(name: .removeLoadingViewController, object: nil, userInfo: nil)
    }
  }

  private func makeRequest(location: CLLocation?) -> Promise<UbsList> {
    return Promise { seal in
      let data = json.data(using: .utf8)!
      do {
        let ubsList = try JSONDecoder().decode(UbsList.self, from: data)
        ubsList.updateWith(location: location)
        seal.fulfill(ubsList)
      } catch {
        seal.reject(error)
      }
    }
  }
}
