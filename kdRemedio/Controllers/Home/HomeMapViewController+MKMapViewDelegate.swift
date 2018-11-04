import MapKit
import UIKit

extension HomeMapViewController: MKMapViewDelegate {

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
