//
//  UINavigationBar+Ext.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 16.06.2021.
//

import UIKit

extension UINavigationBar {
  
  func setNavBar() {
    UINavigationBar.appearance().barTintColor = .white
    UINavigationBar.appearance().titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.systemTeal,
      NSAttributedString.Key.font: UIFont.navBarTitleFont
    ]
    UINavigationBar.appearance().isTranslucent = false
    UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.buttonFont], for: .normal)
    tintColor = .systemTeal
  }
  
}
