import MapKit
import UIKit

class HomeMapViewController: UIViewController {

  var resultSearchController: UISearchController = UISearchController(searchResultsController: nil)
  lazy var presenter: HomeMapViewPresenter = HomeMapViewPresenter(view: self)

  @IBOutlet weak var mapView: MKMapView?

  override func viewDidLoad() {
    super.viewDidLoad()
    mapView?.delegate = self
    presenter.viewDidLoad()
  }

  @IBAction func buttonHistoric(_ sender: Any) {
    presenter.historicClicked()
  }
}
