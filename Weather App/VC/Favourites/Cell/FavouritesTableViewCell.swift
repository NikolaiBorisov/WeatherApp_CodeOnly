//
//  FavoritesTableViewCell.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 24.05.2021.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {
  
  private lazy var cityNameLabel: UILabel = {
    let label = UILabel()
    label.setupLabel()
    return label
  }()
  
  private lazy var temperatureLabel: UILabel = {
    let label = UILabel()
    label.setupLabel()
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupLayouts()
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
  private func setupLayouts() {
    [
      cityNameLabel,
      temperatureLabel
    ]
    .forEach {
      contentView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      
      cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
      cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
      cityNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      temperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
      temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
      
    ])
  }
  
  func configure(with item: FavoritesDisplayItem) {
    cityNameLabel.text = item.city
    temperatureLabel.text = item.temperature
  }
  
}
