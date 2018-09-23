import Foundation
import MapKit

class UBSAnnotation: MKPointAnnotation {

  let ubs: UBS

  init(ubs: UBS) {
    self.ubs = ubs
    super.init()
    self.coordinate = CLLocationCoordinate2D(latitude: ubs.coordinate.coordinate.latitude, longitude: ubs.coordinate.coordinate.longitude)
    self.title = ubs.name
  }

}
