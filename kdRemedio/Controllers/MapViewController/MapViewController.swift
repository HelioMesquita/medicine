import MapKit
import UIKit

class MapViewController: UIViewController {

  var resultSearchController: UISearchController?
  var presenter: MapViewPresenter?

  @IBOutlet weak var mapView: MKMapView?

  override func viewDidLoad() {
    super.viewDidLoad()
    mapView?.delegate = self
    presenter = MapViewPresenter(delegate: self)
    presenter?.viewDidLoad()
  }
}

extension MapViewController: MKMapViewDelegate {

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is MKUserLocation { return nil }

    let reuseId = "Pin"
    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
    if let pinView = pinView {
      pinView.annotation = annotation
    } else {
      pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
      pinView?.canShowCallout = true

      let rightButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
      pinView?.rightCalloutAccessoryView = rightButton
    }

    return pinView
  }

  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    guard let viewController = R.storyboard.main.medicineSelection(), let ubsAnnotation = view.annotation as? UBSAnnotation else { return }
    let ubs = ubsAnnotation.ubs
    viewController.ubs = ubs
    viewController.navigationItem.title = ubs.name
    navigationController?.pushViewController(viewController, animated: true)
  }
}

extension MapViewController: MapViewHandlable {

  func configureMapView() {
    mapView?.userLocation.title = "Minha localização"
  }

  func configureSearchBar() {
    let medicineFinderViewController = R.storyboard.main.medicineFinder()
    medicineFinderViewController?.delegate = self

    resultSearchController = UISearchController(searchResultsController: medicineFinderViewController)
    resultSearchController?.searchResultsUpdater = medicineFinderViewController
    resultSearchController?.obscuresBackgroundDuringPresentation = false
    resultSearchController?.hidesNavigationBarDuringPresentation = false
    resultSearchController?.dimsBackgroundDuringPresentation = true

    let searchBar = resultSearchController?.searchBar
    searchBar?.tintColor = UIColor.white
    searchBar?.barTintColor = UIColor.white
    searchBar?.sizeToFit()
    searchBar?.placeholder = "Digite nome do remédio"
    navigationItem.searchController = resultSearchController
    navigationItem.largeTitleDisplayMode = .always

    definesPresentationContext = true
  }

  func showAlertError(error: Error) {
    let alert = UIAlertController(title: "Alerta", message: "Ocorreu um erro \(error.localizedDescription)", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { _ in
      self.presenter?.load()
    }))
    present(alert, animated: true, completion: nil)
  }

  func setMapLocation(region: CLLocation) {
    let viewRegion = MKCoordinateRegion(center: region.coordinate, latitudinalMeters: 6000, longitudinalMeters: 6000)
    mapView?.setRegion(viewRegion, animated: true)
  }

  func setMapAnnotations(annotations: [MKPointAnnotation]) {
    mapView?.addAnnotations(annotations)
  }
}

extension MapViewController: MedicineFinderHandable {

  func presentUBSMedicineSelection(with medicineName: String) {
    guard let ubsMedicineSelectionVC = R.storyboard.main.ubsSelection() else { return }
    let list = UbsManager.getList().ubsWithMedicineWhere(contains: medicineName)
    ubsMedicineSelectionVC.list = list
    ubsMedicineSelectionVC.navigationItem.title = medicineName
    navigationController?.pushViewController(ubsMedicineSelectionVC, animated: true)
  }
}
