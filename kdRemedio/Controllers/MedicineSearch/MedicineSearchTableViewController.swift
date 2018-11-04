import UIKit

protocol MedicineSearchHandable: class {
  func presentUBSMedicineSelection(with medicineName: String)
}

class MedicineSearchTableViewController: UITableViewController {

  var medicines: [String] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }
  weak var delegate: MedicineSearchHandable?

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

extension MedicineSearchTableViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    guard let searchBarText = searchController.searchBar.text else { return }
    medicines = UBSManager.getList().medicinesNameWhere(contains: searchBarText)
  }
}
