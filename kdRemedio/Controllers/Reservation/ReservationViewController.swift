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

extension ReservationViewController: ReservationPresentable {

  func showCPFInvalidAlert() {
    let alert = UIAlertController(title: "Alerta", message: "CPF inválido", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }

  func showRequestError(error: Error) {
    let alert = UIAlertController(title: "Alerta", message: "Ocorreu um erro \(error.localizedDescription)", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { _ in
      self.reserve()
    }))
    present(alert, animated: true, completion: nil)
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
}
