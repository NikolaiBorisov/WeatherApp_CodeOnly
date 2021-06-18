//
//  AlertController.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 18.06.2021.
//

import UIKit

protocol LoadableAlertController {
  func presentAlertController(_ error: Error)
}

extension LoadableAlertController where Self: UIViewController {
  
  func presentAlertController(_ error: Error) {
    DispatchQueue.main.async {
      let alertController = UIAlertController(
        title: Constants.LoadableAlertController.title,
        message: Constants.LoadableAlertController.message,
        preferredStyle: .alert
      )
      alertController.addAction(
        UIAlertAction(title: Constants.LoadableAlertController.dismissButton,
                      style: .destructive,
                      handler: nil)
      )
      self.present(alertController, animated: true)
    }
  }
}
