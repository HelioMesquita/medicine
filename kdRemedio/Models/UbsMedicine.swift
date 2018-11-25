import Foundation

class UbsMedicine {
  let name: String
  let address: String
  let googleMaps: URL
  let medicine: Medicine?
  var distance: String

  var distanceNumber: Double {
    let formatNumber = NumberFormatter()
    formatNumber.maximumFractionDigits = 2
    formatNumber.minimumIntegerDigits = 1
    formatNumber.locale = Locale(identifier: "pt_BR")
    return formatNumber.number(from: distance)?.doubleValue ?? 0
  }

  init(name: String, address: String, googleMaps: URL, medicine: Medicine, distance: String) {
    self.name = name
    self.address = address
    self.googleMaps = googleMaps
    self.distance = distance
    self.medicine = medicine
  }

  init(medicine: Medicine, ubs: UBS) {
    self.name = ubs.name
    self.address = ubs.address
    self.googleMaps = ubs.googleMaps
    self.distance = ubs.distance
    self.medicine = medicine
  }
}
