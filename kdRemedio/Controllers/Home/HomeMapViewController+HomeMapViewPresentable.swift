import MapKit
import UIKit

extension HomeMapViewController: HomeMapViewPresentable {

  func openHistoric() {
    guard let historic = R.storyboard.main.historic() else { return }
    navigationController?.pushViewController(historic, animated: true)
  }

  func showCPFInvalidAlert() {
    let alert = UIAlertController(title: "Alerta", message: "CPF inválido", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }

  func showCPFInsertAlert() {
    let alert = UIAlertController(title: "Digite o seu CPF", message: nil, preferredStyle: .alert)
    alert.addTextField(configurationHandler: nil)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] _ in
      if let cpf = alert?.textFields?.first?.text {
        self.presenter.handleCPF(cpf: cpf)
      }
    }))
    present(alert, animated: true, completion: nil)
  }

  func configureMapView() {
    mapView?.userLocation.title = "Minha localização"
  }

  func configureSearchBar() {
    let medicineFinderViewController = R.storyboard.main.medicineFinder()
    medicineFinderViewController?.delegate = self

    resultSearchController = UISearchController(searchResultsController: medicineFinderViewController)
    resultSearchController.searchResultsUpdater = medicineFinderViewController
    resultSearchController.obscuresBackgroundDuringPresentation = false
    resultSearchController.hidesNavigationBarDuringPresentation = false
    resultSearchController.dimsBackgroundDuringPresentation = true

    let searchBar = resultSearchController.searchBar
    searchBar.tintColor = UIColor.white
    searchBar.barTintColor = UIColor.white
    searchBar.sizeToFit()
    searchBar.placeholder = "Digite nome do remédio"
    navigationItem.searchController = resultSearchController
    navigationItem.largeTitleDisplayMode = .always

    definesPresentationContext = true
  }

  func showLoadError(error: Error) {
    let alert = UIAlertController(title: "Alerta", message: "Ocorreu um erro \(error.localizedDescription)", preferredStyle: .alert)
    let action = UIAlertAction(title: "Tentar novamente", style: .default, handler: { _ in self.presenter.load() })
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }

  func setMapLocation(region: CLLocation) {
    let viewRegion = MKCoordinateRegion(center: region.coordinate, latitudinalMeters: 6000, longitudinalMeters: 6000)
    mapView?.setRegion(viewRegion, animated: true)
  }

  func setMapAnnotations(annotations: [MKPointAnnotation]) {
    mapView?.addAnnotations(annotations)
  }
}

extension HomeMapViewController: MedicineSearchHandable {

  func presentUBSMedicineSelection(with medicineName: String) {
    guard let ubsMedicineSelectionVC = R.storyboard.main.ubsSelection() else { return }
    let list = UBSManager.getList().ubsWithMedicineWhere(contains: medicineName)
    ubsMedicineSelectionVC.list = list
    ubsMedicineSelectionVC.navigationItem.title = medicineName
    navigationController?.pushViewController(ubsMedicineSelectionVC, animated: true)
  }
}
