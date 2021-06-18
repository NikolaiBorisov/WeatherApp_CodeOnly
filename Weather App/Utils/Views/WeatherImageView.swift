//
//  WeatherImageView.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 18.06.2021.
//

import UIKit

class WeatherImageView: UIImageView {
  
  init() {
    super.init(frame: .zero)
    self.configureSelf()
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
  private func configureSelf() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.layer.cornerRadius = 10
    self.clipsToBounds = true
  }
  
}
