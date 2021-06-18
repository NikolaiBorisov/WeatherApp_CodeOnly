//
//  UIFont+Ext.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 12.06.2021.
//

import UIKit

extension UIFont {
  
  static var textFieldFont: UIFont {
    return UIFont(name: "Avenir Next Medium", size: 30) ?? UIFont.systemFont(ofSize: 30)
  }
  
  static var coordinateLabelFont: UIFont {
    return UIFont(name: "Avenir Next Medium", size: 20) ?? UIFont.systemFont(ofSize: 20)
  }
  
  static var buttonFont: UIFont {
    return UIFont(name: "Avenir Next Medium", size: 20) ?? UIFont.systemFont(ofSize: 20)
  }
  
  static var navBarTitleFont: UIFont {
    return UIFont(name: "Avenir Next Medium", size: 25) ?? UIFont.systemFont(ofSize: 25)
  }
  
}
