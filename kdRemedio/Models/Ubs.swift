import Foundation
import MapKit

class Ubs: Decodable {
  let name: String
	let address: String
	let googleMaps: URL
	let coordinate: Coordinate
	let medicines: [Medicine]
  var distance: Int?

  init(name: String, address: String, googleMaps: URL, coordinate: Coordinate, medicines: [Medicine], distance: Int?) {
    self.name = name
    self.address = address
    self.googleMaps = googleMaps
    self.coordinate = coordinate
    self.medicines = medicines
    self.distance = distance
  }

	enum CodingKeys: String, CodingKey {
		case name = "name"
		case address = "address"
		case googleMaps = "google_maps"
		case coordinate = "coordinate"
		case medicines = "medicines"
	}

  func coordinates() -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
  }

  func coordinates() -> CLLocation {
    return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
  }

  func annotation() -> MKPointAnnotation {
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinates()
    annotation.title = name
    return annotation
  }
}
