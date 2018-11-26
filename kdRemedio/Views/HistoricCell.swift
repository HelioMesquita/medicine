import UIKit

class HistoricCell: UITableViewCell {

  @IBOutlet weak var pharmacy: UILabel?
  @IBOutlet weak var medicine: UILabel?
  @IBOutlet weak var date: UILabel?
  @IBOutlet weak var amount: UILabel?

  func fill(historic: Historic) {
    pharmacy?.text = historic.pharmacy
    medicine?.text = historic.medicine
    date?.text = "Data: \(historic.formartDate() ?? "")"
    amount?.text =  String(historic.amount) + " unidades"
  }
}
