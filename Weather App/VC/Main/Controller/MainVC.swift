//
//  MainVC.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 08.06.2021.
//

import UIKit
import CoreLocation
import RxSwift

class MainVC: UIViewController, LoadableAlertController {
  
  private let viewModel = MainViewModel()
  private var disposeBag = DisposeBag()
  
  // MARK: - Setting UI Elements
  
  private lazy var searchTextField: UITextField = {
    let textField = CityTextField(placeholder: Constants.Placeholder.textFieldPlaceholder)
    textField.delegate = self
    return textField
  }()
  
  private lazy var temperatureLabel: UILabel = {
    let label = CityTemperatureLabel()
    return label
  }()
  
  private lazy var locationAndSearchButtonStack: UIStackView = {
    let stackView = UIStackView()
    stackView.addArrangedSubview(createButtonFor(type: .Location))
    stackView.addArrangedSubview(createButtonFor(type: .Search))
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 1
    return stackView
  }()
  
  private func createButtonFor(type: CustomButton.WAButtonType) -> CustomButton {
    let button = CustomButton(type: type)
    switch type {
    case .Map:
      button.addTarget(self, action: #selector(onMapButtonPressed(_:)), for: .touchUpInside)
    case .Favourites:
      button.addTarget(self, action: #selector(onFavoritesButtonPressed(_:)), for: .touchUpInside)
    case .Search:
      button.addTarget(self, action: #selector(onSearchButtonPressed(_:)), for: .touchUpInside)
    case .Location:
      button.addTarget(self, action: #selector(onLocationButtonPressed(_:)), for: .touchUpInside)
    case .Select: break
    }
    return button
  }
  
  private lazy var mainStack: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(searchTextField)
    stackView.addArrangedSubview(locationAndSearchButtonStack)
    stackView.addArrangedSubview(createButtonFor(type: .Map))
    stackView.addArrangedSubview(createButtonFor(type: .Favourites))
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 1
    return stackView
  }()
  
  private lazy var gifImageViewContainer: UIImageView = {
    let imageView = WeatherImageView()
    imageView.loadGif(name: Constants.Gif.name)
    return imageView
  }()
  
  private lazy var conditionImageView: UIImageView = {
    let imageView = WeatherImageView()
    imageView.tintColor = .white
    return imageView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemTeal
    viewModel.locationManager.delegate = self
    setupHideKeyboardOnTaps()
    setupBindings()
    setupLayouts()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  // MARK: - Subscribing for Data Updates
  
  func setupBindings() {
    viewModel.temperature
      .bind(to: temperatureLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.name
      .bind(to: searchTextField.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.icon
      .bind(to: conditionImageView.rx.image)
      .disposed(by: disposeBag)
    
    viewModel.error
      .bind { [weak self] error in
        self?.presentAlertController(error)
      }
      .disposed(by: disposeBag)
  }
  
  // MARK: - Setting Layouts
  
  private func setupLayouts() {
    [
      temperatureLabel,
      mainStack,
      gifImageViewContainer,
      conditionImageView
    ]
    .forEach {
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      
      mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
      mainStack.heightAnchor.constraint(equalToConstant: 203.0),
      
      gifImageViewContainer.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 5.0),
      gifImageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      gifImageViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      gifImageViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5.0),
      
      temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      temperatureLabel.bottomAnchor.constraint(equalTo: mainStack.topAnchor, constant: -10.0),
      
      conditionImageView.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -10),
      conditionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      conditionImageView.heightAnchor.constraint(equalToConstant: 150.0),
      conditionImageView.widthAnchor.constraint(equalToConstant: 150)
      
    ])
  }
  
  // MARK:- Main Logic
  
  private func getTemperatureFor(city: String) {
    self.viewModel.getTemperatureFor(city: city)
  }
  
  private func getTemperatureFor(location: CLLocationCoordinate2D) {
    self.viewModel.getTemperatureFor(location: location)
  }
  
  private func requestAthorization() {
    self.viewModel.requestAthorization()
  }
  
  // MARK: - UIButtons Actions
  
  @objc func onSearchButtonPressed(_ sender: UIButton) {
    guard let text = searchTextField.text, !text.isEmpty else { return }
    getTemperatureFor(city: text)
    view.endEditing(true)
  }
  
  @objc func onLocationButtonPressed(_ sender: UIButton) {
    requestAthorization()
  }
  
  @objc func onMapButtonPressed(_ sender: UIButton) {
    let vc = MapVC()
    vc.modalPresentationStyle = .fullScreen
    vc.delegate = self
    vc.viewModel.lastSelectedLocation = viewModel.lastselectedlocation
    present(vc, animated: true)
  }
  
  @objc func onFavoritesButtonPressed(_ sender: UIButton) {
    let vc = FavouritesVC()
    navigationController?.pushViewController(vc, animated: true)
  }
  
}

// MARK: - CLLocationManager and MapVC Delegate

extension MainVC: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      getTemperatureFor(location: location.coordinate)
    }
  }
  
}

extension MainVC: MapViewControllerDelegate {
  
  func didSelectlocation(location: CLLocationCoordinate2D) {
    getTemperatureFor(location: location)
    viewModel.lastselectedlocation = location
  }
  
}

// MARK: - TextFieldDelegate

extension MainVC: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
