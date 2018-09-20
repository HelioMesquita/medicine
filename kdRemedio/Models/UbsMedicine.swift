import Foundation

class UbsMedicine {
  let name: String
  let address: String
  let googleMaps: URL
  let medicine: Medicine?
  var distance: Int?

  init(name: String, address: String, googleMaps: URL, medicine: Medicine, distance: Int?) {
    self.name = name
    self.address = address
    self.googleMaps = googleMaps
    self.distance = distance
    self.medicine = medicine
  }

  init(medicineName: String, ubs: Ubs) {
    self.name = ubs.name
    self.address = ubs.address
    self.googleMaps = ubs.googleMaps
    self.distance = ubs.distance
    self.medicine = ubs.medicines.first { (medicine) -> Bool in
      return medicine.name == medicineName
    }
  }
}
