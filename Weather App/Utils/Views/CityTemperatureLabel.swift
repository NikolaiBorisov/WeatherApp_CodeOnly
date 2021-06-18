//
//  CityTemperatureLabel.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 18.06.2021.
//

import UIKit

class CityTemperatureLabel: UILabel {
  
  init() {
    super.init(frame: .zero)
    self.configureSelf()
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
  private func configureSelf() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.numberOfLines = 0
    self.backgroundColor = .clear
    self.textAlignment = .center
    self.textColor = .white
    self.font = .textFieldFont
  }
  
}


