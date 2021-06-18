//
//  MapVCModel.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 08.06.2021.
//

import Foundation
import MapKit

class MapViewModel {
  
  weak var delegate: MapViewControllerDelegate?
  var lastSelectedLocation: CLLocationCoordinate2D?
  
  func setupInitialRegionIfNeeded(callBack: @escaping ((MKCoordinateRegion) -> Void)) {
    guard let location = lastSelectedLocation else { return }
    let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
    callBack(region)
  }
  
}
