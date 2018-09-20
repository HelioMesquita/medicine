import UIKit

class DetailTableViewController: UITableViewController {

  var list: [UbsMedicine] = []

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return list.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTableViewCell
    cell.accessoryType = .disclosureIndicator
    cell.setCell(ubsMedicine: list[indexPath.row])
    return cell
  }
}
