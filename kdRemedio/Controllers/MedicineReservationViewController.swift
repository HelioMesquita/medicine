import UIKit

class MedicineReservationViewController: UITableViewController {

  var ubsMedicine: UbsMedicine?

  @IBOutlet weak var titleLabel: UILabel?
  @IBOutlet weak var addressLabel: UILabel?
  @IBOutlet weak var distanceLabel: UILabel?
  @IBOutlet weak var quantityRequired: UILabel?
  @IBOutlet weak var stepper: UIStepper?
  @IBOutlet weak var quantityAvailable: UILabel?
  @IBOutlet weak var reserveMessage: UILabel?
  @IBOutlet weak var reserveButton: UIButton?
  @IBOutlet weak var openMapButton: UIButton?

  @IBAction func stepperAction(_ sender: UIStepper) {
    quantityRequired?.text = String(Int(sender.value))
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    openMapButton?.addTarget(self, action: #selector(openMap), for: .touchUpInside)
    setScreen()
  }

  @objc func openMap() {
    guard let url = ubsMedicine?.googleMaps else { return }
    UIApplication.shared.open(url)
  }

  func setScreen() {
    titleLabel?.text = ubsMedicine?.name
    addressLabel?.text = ubsMedicine?.address
    distanceLabel?.text = String(describing: ubsMedicine?.distance ?? "") + " km"
    quantityAvailable?.text = "Total de unidades disponíveis: " + String(describing: ubsMedicine?.medicine?.available ?? 0)
    quantityRequired?.text = String(Int(stepper?.value ?? 0))
    stepper?.maximumValue = Double(ubsMedicine?.medicine?.available ?? 0)
    reserveMessage?.text = "A quantidade reservada não impede que outro usuário pegue o remédio."
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
