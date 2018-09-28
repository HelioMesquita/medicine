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
    return list.map { ubs -> UBSAnnotation in
      return ubs.annotation
    }
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
      let medicine = ubs.medicines.first(where: { (medicine) -> Bool in
        return medicine.name == medicineName
      })

      if let medicine = medicine {
        ubsMedicineList.append(UbsMedicine(medicine: medicine, ubs: ubs))
      }
    }

    return ubsMedicineList
  }
}
