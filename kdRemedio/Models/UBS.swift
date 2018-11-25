import Foundation
import MapKit

class UBS: Decodable {

  private let coordinateModel: Coordinate
  let name: String
	let address: String
	let googleMaps: URL
	let medicines: [Medicine]
  var distance: String = ""

  init(name: String, address: String, googleMaps: URL, coordinateModel: Coordinate, medicines: [Medicine], distance: String) {
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

  var headerTitle: String {
    return "A distância de \(distance) km"
  }

  func updateDistance(location: CLLocation) {
    let distanceInMeters = location.distance(from: self.coordinate) as Double
    let distanceInKilometers = NSNumber(value: distanceInMeters/1000)
    let formatNumber = NumberFormatter()
    formatNumber.maximumFractionDigits = 2
    formatNumber.minimumIntegerDigits = 1
    formatNumber.locale = Locale(identifier: "pt_BR")
    self.distance = formatNumber.string(from: distanceInKilometers) ?? ""
  }
}
