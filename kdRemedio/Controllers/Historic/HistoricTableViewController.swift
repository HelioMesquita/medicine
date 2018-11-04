import UIKit

class HistoricTableViewController: UITableViewController {

  lazy var presenter: HistoricPresenter = HistoricPresenter(view: self)
  var historic: [Historic] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return historic.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    cell.textLabel?.text = historic[indexPath.row].formartDate()
    return cell
  }
}
