import UIKit

protocol MedicineFinderHandable: class {
  func presentDetailViewController(with name: String)
}

class MedicineFinderTableViewController: UITableViewController {

  var medicines: [String] = []
  weak var delegate: MedicineFinderHandable?

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return medicines.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    cell.textLabel?.text = medicines[indexPath.row]
    cell.accessoryType = .disclosureIndicator
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let medicineName = tableView.cellForRow(at: indexPath)?.textLabel?.text else { return }
    delegate?.presentDetailViewController(with: medicineName)
  }
}

extension MedicineFinderTableViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    guard let searchBarText = searchController.searchBar.text else { return }
    medicines = UbsManager.getList().medicinesNameWhere(contains: searchBarText)
    tableView.reloadData()
  }
}
