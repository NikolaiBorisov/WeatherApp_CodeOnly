//
//  CityTextField.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 18.06.2021.
//

import UIKit

class CityTextField: UITextField {
  
  init(placeholder: String) {
    super.init(frame: .zero)
    self.configureSelf(placeholder: placeholder)
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
  private func configureSelf(placeholder: String) {
    self.placeholder = placeholder
    self.textAlignment = .center
    self.backgroundColor = .clear
    self.textColor = .white
    self.layer.cornerRadius = 6
    self.layer.borderWidth = 2
    self.layer.borderColor = UIColor.white.cgColor
    self.font = .textFieldFont
  }
  
}
