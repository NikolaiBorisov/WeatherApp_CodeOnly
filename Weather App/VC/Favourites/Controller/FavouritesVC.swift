//
//  FavouritesVC.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 16.06.2021.
//

import UIKit

import RxSwift
import RxCocoa

class FavouritesVC: UIViewController, LoadableAlertController {
  
  var viewModel: FavouriteViewModel = FavouriteViewModel()
  private var disposebag = DisposeBag()
  
  private lazy var favoutitesTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.frame = view.frame
    view.addSubview(tableView)
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupFavouritesVC()
    setupNavigationBar()
    viewModel.getData()
    setupBindings()
  }
  
  // MARK: - Subscribing for Data Updates
  
  private func setupBindings() {
    viewModel.indexToUpdate
      .bind { [weak self] indexToUpdate in
        self?.favoutitesTableView.reloadRows(
          at: [IndexPath(row: indexToUpdate, section: 0)],
          with: .automatic
        )
      }
      .disposed(by: disposebag)
    
    viewModel.error
      .bind { [weak self] error in
        self?.presentAlertController(error)
      }
      .disposed(by: disposebag)
  }
  
  // MARK: - Setting UI
  
  private func setupNavigationBar() {
    navigationController?.navigationBar.setNavBar()
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: Constants.Image.addButtonImage),
      style: .done,
      target: self,
      action: #selector(onAddButtonPressed(_:))
    )
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: Constants.Image.backButtonImage),
      style: .plain,
      target: self,
      action: #selector(onBackButtonTapped))
  }
  
  private func setupFavouritesVC() {
    title = Constants.Title.favouritesNavBarTitle
    favoutitesTableView.register(
      FavouritesTableViewCell.self,
      forCellReuseIdentifier: Constants.CellProperty.cellIdentifier
    )
  }
  
  // MARK: - Tab Bar Buttons Actions
  
  @objc private func onBackButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func onAddButtonPressed(_ sender: Any) {
    let controller = createAlertController()
    present(controller, animated: true)
  }
  
  // MARK: - Add Favourite City Alert Controller
  
  func createAlertController() -> UIAlertController {
    let controller = UIAlertController(
      title: Constants.AddCityAlertController.title,
      message: Constants.AddCityAlertController.message,
      preferredStyle: .alert
    )
    let closeAction = UIAlertAction(title: Constants.AddCityAlertController.closeActionTitle, style: .destructive) { (_) in
      controller.dismiss(animated: true)
    }
    
    let saveAction = UIAlertAction(title: Constants.AddCityAlertController.saveActionTitle, style: .default) { [weak self] _ in
      if let textField = controller.textFields?.first,
         let text = textField.text {
        self?.viewModel.addCity(cityName: text) { [weak self] in
          self?.favoutitesTableView.reloadData()
        }
      }
    }
    controller.addTextField()
    controller.addAction(closeAction)
    controller.addAction(saveAction)
    return controller
  }
  
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FavouritesVC: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Constants.CellProperty.rowHeight
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let item = viewModel.displayItems[indexPath.row]
    (cell as? FavouritesTableViewCell)?.configure(with: item)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.displayItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: Constants.CellProperty.cellIdentifier, for: indexPath)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if case .delete = editingStyle {
      self.viewModel.delete(at: indexPath.row) { [weak self] in
        self?.favoutitesTableView.reloadData()
      }
    }
  }
  
}

