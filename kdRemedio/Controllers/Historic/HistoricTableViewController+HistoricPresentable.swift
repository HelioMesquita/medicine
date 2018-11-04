import UIKit

extension HistoricTableViewController: HistoricPresentable {

  func loadScreen(historic: [Historic]) {
    self.historic = historic
  }

  func showLoadError(error: Error) {
    let alert = UIAlertController(title: "Alerta", message: "Ocorreu um erro \(error.localizedDescription)", preferredStyle: .alert)
    let action = UIAlertAction(title: "Tentar novamente", style: .default, handler: { _ in self.presenter.load() })
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }

  func configureNavigation() {
    navigationItem.title = "Histórico"
  }
}
