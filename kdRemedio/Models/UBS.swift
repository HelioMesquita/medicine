import Foundation
import MapKit

class UBS: Decodable {

  private let coordinateModel: Coordinate
  let name: String
	let address: String
	let googleMaps: URL
	let medicines: [Medicine]
  var distance: Int?

  init(name: String, address: String, googleMaps: URL, coordinateModel: Coordinate, medicines: [Medicine], distance: Int?) {
    self.name = name
    self.address = address
    self.googleMaps = googleMaps
    self.coordinateModel = coordinateModel
    self.medicines = medicines
    self.distance = distance
  }

	enum CodingKeys: String, CodingKey {
		case name = "name"
		case address = "address"
		case googleMaps = "google_maps"
		case coordinateModel = "coordinate"
		case medicines = "medicines"
	}

  var coordinate: CLLocation {
    return CLLocation(latitude: coordinateModel.latitude, longitude: coordinateModel.longitude)
  }

  var annotation: UBSAnnotation {
    return UBSAnnotation(ubs: self)
  }

  func updateDistance(location: CLLocation) {
    distance = Int(location.distance(from: ubs.coordinate)/1000)
  }
}
