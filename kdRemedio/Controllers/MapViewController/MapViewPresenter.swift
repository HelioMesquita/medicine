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

  private func load() {
    firstly {
      after(seconds: 0).done { _ = LoadingViewController() }
    }.then {
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
      DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
        NotificationCenter.default.post(name: .removeLoadingViewController, object: nil, userInfo: nil)
      })
    }
  }

  private func makeRequest(location: CLLocation?) -> Promise<UBSList> {
    return Promise { seal in
      let data = json.data(using: .utf8)!
      do {
        let ubsList = try JSONDecoder().decode(UBSList.self, from: data)
        ubsList.update(location: location)
        seal.fulfill(ubsList)
      } catch {
        seal.reject(error)
      }
    }
  }
}
