//
//  NetworkRequest+Ext.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 17.05.2021.
//

import Foundation

extension NetworkRequest {
  
  func tryToBuildUrlRequest(with apiKey: String) -> URLRequest? {
    
    var components = URLComponents()
    components.scheme = Constants.ApiComponent.scheme
    components.host = Constants.ApiComponent.host
    components.path = Constants.ApiComponent.path
    
    var queryItems: [URLQueryItem] = [.init(name: Constants.ApiComponent.queryItemsName, value: apiKey)]
    queryItems.append(contentsOf: self.queryItems)
    components.queryItems = queryItems
    
    guard let url = components.url else { return nil }
    
    var request = URLRequest(url: url)
    request.timeoutInterval = Constants.ApiComponent.timeoutInterval
    
    return request
  }
  
}

fileprivate extension NetworkRequest {
  
  var queryItems: [URLQueryItem] {
    var queryItems = [URLQueryItem]()
    self.path.components(separatedBy: Constants.ApiComponent.queryItemsSeparator1).forEach {
      let queryComponents = $0.components(separatedBy: Constants.ApiComponent.queryItemsSeparator2)
      queryItems.append(.init(name: queryComponents[0], value: queryComponents[1]))
    }
    return queryItems
  }
  
}

extension NetworkRequest where Response == [String : Any] {
  
  func decode(data: Data, with decoder: JSONDecoder) throws -> Response {
    guard !data.isEmpty else { return [:] }
    guard let response = try JSONSerialization.jsonObject(with: data, options: []) as? Response else {
      throw WAError.Decoding.failedToDecodeData
    }
    return response
  }
  
}

extension NetworkRequest where Response: Decodable {
  
  func decode(data: Data, with decoder: JSONDecoder) throws -> Response {
    return try decoder.decode(Response.self, from: data)
  }
  
}
