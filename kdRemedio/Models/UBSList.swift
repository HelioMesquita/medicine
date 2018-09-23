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

  func ubsWithMedicineWhere(contains medicineName: String) -> [UbsMedicine] {
    var ubsMedicineList: [UbsMedicine] = []

    list.forEach { (ubs) in
      if ubs.medicines.contains(where: { medicine -> Bool in return medicine.name == medicineName }) {
        ubsMedicineList.append(UbsMedicine(medicineName: medicineName, ubs: ubs))
      }
    }

    return ubsMedicineList
  }
}
