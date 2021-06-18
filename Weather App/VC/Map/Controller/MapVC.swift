//
//  MapVC.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 16.06.2021.
//

import UIKit
import MapKit

class MapVC: UIViewController {
  
  weak var delegate: MapViewControllerDelegate?
  let viewModel: MapViewModel = MapViewModel()
  
  // MARK: - Setting UI Elements
  
  private lazy var closeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .red
    button.setImage(UIImage(systemName: Constants.Image.closeButton), for: .normal)
    button.addTarget(self, action: #selector(onCloseButtonPressed(_:)), for: .touchUpInside)
    return button
  }()
  
  private lazy var coordinateLabel: UILabel = {
    let label = CoordinateLabel()
    label.text = mapView.centerCoordinate.stringInterpolation
    return label
  }()
  
  private lazy var doneButton: UIButton = {
    let button = CustomButton(type: .Select)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(onSelectButtonPressed(_:)), for: .touchUpInside)
    return button
  }()
  
  private lazy var centralDot: UIView = {
    let dot = CentralDot()
    return dot
  }()
  
  private lazy var mapView: MKMapView = {
    let map = MKMapView()
    map.translatesAutoresizingMaskIntoConstraints = false
    map.delegate = self
    return map
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupInitialRegionIfNeeded()
    setupLayouts()
  }
  
  // MARK: - Setting Layouts
  
  private func setupLayouts() {
    
    [
      mapView,
      closeButton,
      coordinateLabel,
      doneButton,
      centralDot
    ]
    .forEach {
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      
      mapView.topAnchor.constraint(equalTo: view.topAnchor),
      mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
      closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
      closeButton.heightAnchor.constraint(equalToConstant: 30.0),
      closeButton.widthAnchor.constraint(equalToConstant: 30.0),
      
      coordinateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
      coordinateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30.0),
      doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
      doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
      doneButton.heightAnchor.constraint(equalToConstant: 50.0),
      
      centralDot.heightAnchor.constraint(equalToConstant: 10.0),
      centralDot.widthAnchor.constraint(equalToConstant: 10.0),
      centralDot.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      centralDot.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      
    ])
  }
  
  private func setupInitialRegionIfNeeded() {
    viewModel.setupInitialRegionIfNeeded { [weak self] region in
      self?.mapView.setRegion(region, animated: false)
    }
  }
  
  // MARK: - UIButtons Actions
  
  @IBAction private func onSelectButtonPressed(_ sender: Any) {
    delegate?.didSelectlocation(location: mapView.centerCoordinate)
    dismiss(animated: true)
  }
  
  @IBAction private func onCloseButtonPressed(_ sender: Any) {
    dismiss(animated: true)
  }
  
}

// MARK: - MKMapViewDelegate

extension MapVC: MKMapViewDelegate {
  
  func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
    coordinateLabel.text = mapView.centerCoordinate.stringInterpolation
  }
  
}
