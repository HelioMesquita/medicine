import UIKit
import MapKit
import PromiseKit

class MapViewController: UIViewController {

  var resultSearchController: UISearchController!

  @IBOutlet weak var mapView: MKMapView?

  override func viewDidLoad() {
    super.viewDidLoad()
    configureSearchBar()
    configureMapView()
  }

  func configureMapView() {
    mapView?.userLocation.title = "Minha localização"

    let locationManager = CLLocationManager()
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

    firstly {
      CLLocationManager.requestLocation()
    }.then { locations in
      self.handleLocation(locations: locations)
    }.then { location in
      self.makeRequest(location: location)
    }.done { ubsList in
      self.mapView?.addAnnotations(ubsList.getAnnotations())
      UbsManager.setList(list: ubsList)
    }.catch { error in
      print(error)
    }
  }

  func makeRequest(location: CLLocation?) -> Promise<UbsList> {
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

  func handleLocation(locations: [CLLocation]) -> Promise<CLLocation?> {
    return Promise { seal in
      if let location = locations.first {
        let viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 6000, 6000)
        self.mapView?.setRegion(viewRegion, animated: true)
        seal.fulfill(location)
      } else {
        seal.fulfill(nil)
      }
    }
  }

  func configureSearchBar() {
    let medicineViewController = storyboard?.instantiateViewController(withIdentifier: "medicineViewController") as! MedicineFinderTableViewController
    medicineViewController.delegate = self

    resultSearchController = UISearchController(searchResultsController: medicineViewController)
    resultSearchController.searchResultsUpdater = medicineViewController
    resultSearchController.obscuresBackgroundDuringPresentation = false
    resultSearchController.hidesNavigationBarDuringPresentation = false
    resultSearchController.dimsBackgroundDuringPresentation = true

    let searchBar = resultSearchController.searchBar
    searchBar.tintColor = UIColor.white
    searchBar.barTintColor = UIColor.white
    searchBar.sizeToFit()
    searchBar.placeholder = "Digite nome do remédio"
    navigationItem.searchController = resultSearchController
    navigationItem.largeTitleDisplayMode = .always

    definesPresentationContext = true
  }

}

extension MapViewController: MedicineFinderHandable {
  func presentDetailViewController(with name: String) {
    let detailViewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailTableViewController
    detailViewController.navigationItem.title = name
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}
