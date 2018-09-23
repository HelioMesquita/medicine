import UIKit
import MapKit

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

      let rightButton = UIButton(type: UIButtonType.detailDisclosure)
      pinView?.rightCalloutAccessoryView = rightButton
    }

    return pinView
  }

  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    let ubsSelectionVC = storyboard?.instantiateViewController(withIdentifier: "ubsSelection") as! UBSSelectionTableViewController
    guard let ubsAnnotation = view.annotation as? UBSAnnotation else { return }
    let ubs = ubsAnnotation.ubs
    ubsSelectionVC.ubs = ubs
    ubsSelectionVC.navigationItem.title = ubs.name
    navigationController?.pushViewController(ubsSelectionVC, animated: true)
  }
}

extension MapViewController: MapViewHandlable {

  func configureMapView() {
    mapView?.userLocation.title = "Minha localização"
  }

  func configureSearchBar() {
    let medicineFinderViewController = storyboard?.instantiateViewController(withIdentifier: "finder") as! MedicineFinderTableViewController
    medicineFinderViewController.delegate = self

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

  }

  func setMapLocation(region: CLLocation) {
    let viewRegion = MKCoordinateRegionMakeWithDistance(region.coordinate, 6000, 6000)
    mapView?.setRegion(viewRegion, animated: true)
  }

  func setMapAnnotations(annotations: [MKPointAnnotation]) {
    mapView?.addAnnotations(annotations)
  }
}

extension MapViewController: MedicineFinderHandable {

  func presentUBSMedicineSelection(with medicineName: String) {
    let ubsMedicineSelectionVC = storyboard?.instantiateViewController(withIdentifier: "medicineSelection") as! UBSMedicineSelectionTableViewController
    let list = UbsManager.getList().ubsWithMedicineWhere(contains: medicineName)
    ubsMedicineSelectionVC.list = list
    ubsMedicineSelectionVC.navigationItem.title = medicineName
    navigationController?.pushViewController(ubsMedicineSelectionVC, animated: true)
  }
}
