import Foundation
import MapKit

class UBSList: Decodable {

	var list: [UBS] = []

  init(list: [UBS]) {
    self.list = list
  }

  enum CodingKeys: String, CodingKey {
    case list = "ubs"
  }

  func update(location: CLLocation?) {
    guard let location = location else { return }
    list.forEach { $0.updateDistance(location: location) }
  }

  func getAnnotations() -> [UBSAnnotation] {
    return list.map { $0.annotation }
  }

  func medicinesNameWhere(contains letters: String) -> [String] {
    var allMedicines: [Medicine] = []
    list.forEach { (ubs) in
      allMedicines.append(contentsOf: ubs.medicines)
    }

    var setOfMedicines: Set<String> = []
    allMedicines.forEach { medicine in
      setOfMedicines.insert(medicine.name)
    }

    return setOfMedicines.filter { word -> Bool in
      return word.contains(letters)
    }
  }

  func ubsWithMedicineWhere(contains medicineName: String) -> [UbsMedicine] {
    var ubsMedicineList: [UbsMedicine] = []

    list.forEach { (ubs) in
      if let medicine = ubs.medicines.first(where: { $0.name == medicineName }) {
        ubsMedicineList.append(UbsMedicine(medicine: medicine, ubs: ubs))
      }
    }

    ubsMedicineList.sort(by: { $0.distanceNumber < $1.distanceNumber })
    return ubsMedicineList
  }
}
