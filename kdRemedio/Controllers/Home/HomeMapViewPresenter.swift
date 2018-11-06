import Foundation
import PromiseKit

protocol HomeMapViewPresentable: class {

  var ubsList: UBSList { get set }

  func configureSearchBar()

  func configureMapView()
  func setMapLocation(region: CLLocation)
  func setMapAnnotations(annotations: [MKPointAnnotation])

  func showLoadError(error: Error)

  func openHistoric()
  func showInsertDocumentAlert()
  func showInvaliDocumentdAlert()
}

class HomeMapViewPresenter {

  weak var view: HomeMapViewPresentable?
  let document: PersonalDocumentManager

  init(view: HomeMapViewPresentable, document: PersonalDocumentManager = PersonalDocumentManager()) {
    self.view = view
    self.document = document
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
      self.view?.ubsList.list.append(contentsOf: ubsList.list) 
      self.view?.setMapLocation(region: location)
      self.view?.setMapAnnotations(annotations: ubsList.getAnnotations())
    }.catch { error in
      self.view?.showLoadError(error: error)
    }.finally {
      DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
        NotificationCenter.default.post(name: .removeLoadingViewController, object: nil, userInfo: nil)
      }
    }
  }

  func historicClicked() {
    if document.hasDocument {
      view?.openHistoric()
    } else {
      view?.showInsertDocumentAlert()
    }
  }

  func handleDocument(document: String) {
    if self.document.isValid(document: document) {
      self.document.save(document: document)
      view?.openHistoric()
    } else {
      view?.showInvaliDocumentdAlert()
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
