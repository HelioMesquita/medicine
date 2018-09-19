import Foundation
import MapKit

class UbsList: Decodable {
	var list: [Ubs] = []

  init(list: [Ubs]) {
    self.list = list
  }

  enum CodingKeys: String, CodingKey {
    case list = "ubs"
  }

  func updateWith(location: CLLocation?) {
    guard let location = location else { return }
    list.forEach { ubs in
      ubs.distance = Int(location.distance(from: ubs.coordinates())/1000)
    }
  }

  func getAnnotations() -> [MKAnnotation] {
    return list.map { ubs -> MKAnnotation in
      return ubs.annotation()
    }
  }

  func medicinesNameWhere(contains letters: String) -> [String] {
    var medicines: Set<String> = []

    list.forEach { ubs in
      ubs.medicines.forEach{ medicine in
        medicines.insert(medicine.name)
      }
    }

    return medicines.filter { word -> Bool in
      return word.contains(letters)
    }
  }

  func ubsWhere(contains medicineName: String) -> [Ubs] {
    return list.filter { ubs -> Bool in
      return ubs.medicines.filter { medicine -> Bool in
        return medicine.name == medicineName
      }.isEmpty
    }
  }
}
