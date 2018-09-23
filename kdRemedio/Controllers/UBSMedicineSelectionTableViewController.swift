import UIKit

class UBSMedicineSelectionTableViewController: UITableViewController {

  var list: [UbsMedicine] = []

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return list.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UBSSelectionCell
    cell.accessoryType = .disclosureIndicator
    cell.setCell(ubsMedicine: list[indexPath.row])
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
