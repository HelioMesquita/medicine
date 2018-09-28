import UIKit

protocol MedicineFinderHandable: class {
  func presentUBSMedicineSelection(with medicineName: String)
}

class MedicineFinderTableViewController: UITableViewController {

  var medicines: [String] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }
  weak var delegate: MedicineFinderHandable?

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return medicines.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = medicines[indexPath.row]
    cell.accessoryType = .disclosureIndicator
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let medicineName = tableView.cellForRow(at: indexPath)?.textLabel?.text else { return }
    delegate?.presentUBSMedicineSelection(with: medicineName)
  }
}

extension MedicineFinderTableViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    guard let searchBarText = searchController.searchBar.text else { return }
    medicines = UbsManager.getList().medicinesNameWhere(contains: searchBarText)
  }
}
