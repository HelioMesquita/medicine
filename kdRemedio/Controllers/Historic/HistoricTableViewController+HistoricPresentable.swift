import UIKit

extension HistoricTableViewController: HistoricPresentable {

  func loadScreen(historic: [Historic]) {
    self.historic = historic
  }

  func showLoadError(error: Error) {
    let alert = UIAlertController(title: "Alerta", message: "Ocorreu um erro \(error.localizedDescription)", preferredStyle: .alert)
    let action1 = UIAlertAction(title: "Tentar novamente", style: .default, handler: { _ in self.presenter.load() })
    let action2 = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
    alert.addAction(action1)
    alert.addAction(action2)
    present(alert, animated: true, completion: nil)
  }

  func configureNavigation() {
    let item = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(showAlertRemoveDocument))
    self.navigationItem.setRightBarButtonItems([item], animated: true)
    navigationItem.title = "Histórico"
  }

  @objc func showAlertRemoveDocument() {
    let alert = UIAlertController(title: "Você deseja remover o CPF salvo?", message: "", preferredStyle: .alert)
    let action1 = UIAlertAction(title: "Não", style: .default, handler: nil)
    let action2 = UIAlertAction(title: "Sim", style: .destructive, handler: { _ in
      self.presenter.removeDocument()
      self.navigationController?.popViewController(animated: true)
    })
    alert.addAction(action1)
    alert.addAction(action2)
    present(alert, animated: true, completion: nil)
  }
}
