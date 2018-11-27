import UIKit

extension ReservationViewController: ReservationPresentable {

  func showAlertGenericError() {
    let alert = UIAlertController(title: nil, message: "Ocorreu alguma falha, tente novamente", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    present(alert, animated: true)
  }

  func showAlertSuccessReservation() {
    let alert = UIAlertController(title: nil, message: "Sua reserva foi realiza com sucesso", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
      self.navigationController?.popToRootViewController(animated: true)
      NotificationCenter.default.post(name: .reloadApp, object: nil, userInfo: nil)
    })
    present(alert, animated: true)
  }

  func showAlerFailReservation(data: String) {
    let alert = UIAlertController(title: nil, message: data, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    present(alert, animated: true)
  }

  func showAlertInvalidCPF() {
    let alert = UIAlertController(title: "Alerta", message: "CPF inválido", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    present(alert, animated: true)
  }

  func showAlertRequestError(error: Error) {
    let alert = UIAlertController(title: "Alerta", message: "Ocorreu um erro \(error.localizedDescription)", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Tentar novamente", style: .default) { _ in
      self.reserve()
    })
    present(alert, animated: true)
  }

  func setScreen() {
    titleLabel?.text = ubsMedicine?.name
    addressLabel?.text = ubsMedicine?.address
    distanceLabel?.text = String(describing: ubsMedicine?.distance ?? "") + " km"
    quantityAvailable?.text = "Total de unidades disponíveis: " + String(describing: ubsMedicine?.medicine?.available ?? 0)
    quantityRequired?.text = String(Int(stepper?.value ?? 0))
    stepper?.maximumValue = Double(ubsMedicine?.medicine?.available ?? 0)
    reserveMessage?.text = "A quantidade reservada não impede que outro usuário pegue o remédio."
    if let name = ubsMedicine?.medicine?.name {
      medicineName?.text = "Remédio: " + name
    }
  }
}
