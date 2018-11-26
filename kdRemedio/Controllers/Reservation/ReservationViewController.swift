import UIKit

class ReservationViewController: UITableViewController {

  lazy var presenter = ReservationPresenter(view: self)
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
  @IBOutlet weak var cpfField: UITextField?

  @IBAction func stepperAction(_ sender: UIStepper) {
    quantityRequired?.text = String(Int(sender.value))
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
    openMapButton?.addTarget(self, action: #selector(openMap), for: .touchUpInside)
    reserveButton?.addTarget(self, action: #selector(reserve), for: .touchUpInside)
    cpfField?.text = PersonalDocumentManager().get()
  }

  @objc func openMap() {
    guard let url = ubsMedicine?.googleMaps else { return }
    UIApplication.shared.open(url)
  }

  @objc func reserve() {
    let link =  ubsMedicine?.medicine?.links.safe
    let cpf = cpfField?.text
    let quantity = String(Int(stepper?.stepValue ?? 0))
    presenter.handleReservation(cpf: cpf, quantity: quantity, link: link)
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
