import UIKit
import MapKit

class MapViewController: UIViewController {

  var resultSearchController: UISearchController?
  var presenter: MapViewPresenter?

  @IBOutlet weak var mapView: MKMapView?

  override func viewDidLoad() {
    super.viewDidLoad()
    mapView?.delegate = self
    self.presenter = MapViewPresenter(delegate: self)
    presenter?.viewDidLoad()
  }

}

extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is MKUserLocation {
      return nil
    }

    let reuseId = "Pin"
    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
    if pinView == nil {
      pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
      pinView?.canShowCallout = true

      let rightButton: AnyObject! = UIButton(type: UIButtonType.detailDisclosure)
      pinView?.rightCalloutAccessoryView = rightButton as? UIView
    }
    else {
      pinView?.annotation = annotation
    }

    return pinView
  }

  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

  }

  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    print(#function)
    if control == view.rightCalloutAccessoryView {
      // Do something
    }
  }
}

extension MapViewController: MapViewHandlable {

  func configureMapView() {
    mapView?.userLocation.title = "Minha localização"
  }

  func configureSearchBar() {
    let medicineViewController = storyboard?.instantiateViewController(withIdentifier: "medicineViewController") as! MedicineFinderTableViewController
    medicineViewController.delegate = self

    resultSearchController = UISearchController(searchResultsController: medicineViewController)
    resultSearchController?.searchResultsUpdater = medicineViewController
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
  func presentDetailViewController(with name: String) {
    let detailViewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailTableViewController
    let list = UbsManager.getList().ubsWithMedicineWhere(contains: name)
    detailViewController.list = list
    detailViewController.navigationItem.title = name
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}
