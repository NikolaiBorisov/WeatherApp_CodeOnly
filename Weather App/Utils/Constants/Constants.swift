//
//  Constants.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 19.05.2021.
//

import UIKit

enum Constants {
  
  enum Storyboard {
    static let map: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
    static let favorites: UIStoryboard = UIStoryboard(name: "Favourites", bundle: nil)
  }
  
  enum Temperature {
    static let oneKelvin: Float = 273.0
  }
  
  enum ApiComponent {
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    static let path = "/data/2.5/weather"
    static let queryItemsName = "appid"
    static let timeoutInterval = 10.0
    static let queryItemsSeparator1 = "&"
    static let queryItemsSeparator2 = "="
    static let apiKey = "b3bffeb203c7788c507e9d19bd2d8538"
  }
  
  enum Placeholder {
    static let textFieldPlaceholder = "Search..."
  }
  
  enum Queue {
    static let queueName = "Weather queue"
  }
  
  enum AddCityAlertController {
    static let title = "Добавьте город"
    static let message = "Введите название города"
    static let closeActionTitle = "Close"
    static let saveActionTitle = "Добавить"
  }
  
  enum LoadableAlertController {
    static let title = "Sorry, but we cannot find this city:(\nPlease, double check entered city name!"
    static let message = "Entered city doesn't exist"
    static let dismissButton = "Dismiss"
  }
  
  enum UserDefaults {
    static let suiteName = "WeatherApp"
  }
  
  enum NSCoder {
    static let fatalError = "init(coder:) has not been implemented"
  }
  
  enum Gif {
    static let name = "weather"
  }
  
  enum Image {
    static let cloudBolt = "cloud.bolt"
    static let cloudDrizzle = "cloud.drizzle"
    static let cloudRain = "cloud.rain"
    static let cloudSnow = "cloud.snow"
    static let cloudFog = "cloud.fog"
    static let sunMax = "sun.max"
    static let cloud = "cloud"
    static let closeButton = "x.circle.fill"
    static let addButtonImage = "plus"
    static let backButtonImage = "arrowshape.turn.up.backward.fill"
  }
  
  enum Title {
    static let selectButton = "Select"
    static let favouritesNavBarTitle = "Favourites"
  }
  
  enum CellProperty {
    static let rowHeight: CGFloat = 50
    static let cellIdentifier =  "cell"
  }
  
  enum Localizable {
    static func degrees(argument: CVarArg) -> String {
      return String(format: NSLocalizedString("degrees", comment: ""), argument)
    }
  }
  
  enum Nib {
    
    static let favoritesTableViewCell: NibResource = .init(name: "FavoritesTableViewCell")
    
    struct NibResource {
      private let name: String
      init(name: String) {
        self.name = name
      }
      var nib: UINib {
        return UINib(nibName: self.name, bundle: nil)
      }
      var identifier: String {
        return name
      }
    }
  }
  
}
