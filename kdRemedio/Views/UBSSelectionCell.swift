import UIKit

class UBSSelectionCell: UITableViewCell {

  @IBOutlet weak var name: UILabel?
  @IBOutlet weak var distance: UILabel?
  @IBOutlet weak var address: UILabel?
  @IBOutlet weak var available: UILabel?

  func setCell(ubsMedicine: UbsMedicine) {
    address?.text = ubsMedicine.address
    name?.text = ubsMedicine.name
    if let distance = ubsMedicine.distance {
      self.distance?.text = distance
    }
    if let available = ubsMedicine.medicine?.available {
      self.available?.text = "\(available) unidades"
    }
  }
}
