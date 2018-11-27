import UIKit

class UBSSelectionTableViewController: UITableViewController {

  var ubs: UBS?

  override func viewDidLoad() {
    super.viewDidLoad()
    ubs?.medicines.sort(by: { $0.available < $1.available })
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let rows = ubs?.medicines.count else { return 0 }
    return rows
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return ubs?.headerTitle
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let medicine = ubs?.medicines[indexPath.row]
    cell.textLabel?.text = medicine?.name
    cell.detailTextLabel?.text = String(describing: medicine?.available ?? 0) + " unidades"
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let viewController = R.storyboard.main.reservation(), let ubs = ubs else { return }
    let medicine = ubs.medicines[indexPath.row]
    viewController.ubsMedicine = UbsMedicine(medicine: medicine, ubs: ubs)
    viewController.navigationItem.title = "Selecione"
    navigationController?.pushViewController(viewController, animated: true)
  }
}
