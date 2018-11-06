import MapKit
import UIKit

extension HomeMapViewController: HomeMapViewPresentable {

  func openHistoric() {
    guard let historic = R.storyboard.main.historic() else { return }
    navigationController?.pushViewController(historic, animated: true)
  }

  func showInvaliDocumentdAlert() {
    let alert = UIAlertController(title: "Alerta", message: "CPF inválido", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }

  func showInsertDocumentAlert() {
    let alert = UIAlertController(title: "Digite o seu CPF", message: nil, preferredStyle: .alert)
    let action1 = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
    let action2 = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] _ in
      if let document = alert?.textFields?.first?.text {
        self.presenter.handleDocument(document: document)
      }
    })
    alert.addTextField(configurationHandler: nil)
    alert.addAction(action1)
    alert.addAction(action2)
    present(alert, animated: true, completion: nil)
  }

  func configureMapView() {
    mapView?.userLocation.title = "Minha localização"
  }

  func configureSearchBar() {
    let medicineSearchViewController = R.storyboard.main.medicineSearch()
    medicineSearchViewController?.list = ubsList
    medicineSearchViewController?.delegate = self

    resultSearchController = UISearchController(searchResultsController: medicineSearchViewController)
    resultSearchController.searchResultsUpdater = medicineSearchViewController
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
    let list = self.ubsList.ubsWithMedicineWhere(contains: medicineName)
    ubsMedicineSelectionVC.list = list
    ubsMedicineSelectionVC.navigationItem.title = medicineName
    navigationController?.pushViewController(ubsMedicineSelectionVC, animated: true)
  }
}
