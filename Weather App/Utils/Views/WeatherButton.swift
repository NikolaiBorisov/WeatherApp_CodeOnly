//
//  WeatherButton.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 08.06.2021.
//

import UIKit

class CustomButton: UIButton {
  
  enum WAButtonType: String {
    case Favourites
    case Map
    case Location
    case Search
    case Select
  }
  
  init(type: WAButtonType) {
    super.init(frame: .zero)
    layer.cornerRadius = 5
    layer.borderWidth = 2
    layer.borderColor = UIColor.white.cgColor
    backgroundColor = .systemRed
    setTitle(type.rawValue, for: .normal)
    titleLabel?.font = .buttonFont
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
}
