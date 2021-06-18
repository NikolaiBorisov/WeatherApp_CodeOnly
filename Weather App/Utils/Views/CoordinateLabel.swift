//
//  CoordinateLabel.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 18.06.2021.
//

import UIKit

class CoordinateLabel: UILabel {
  
  init() {
    super.init(frame: .zero)
    self.configureSelf()
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
  private func configureSelf() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.font = .coordinateLabelFont
    self.numberOfLines = 0
    self.textAlignment = .center
    self.textColor = .darkGray
  }
  
}

