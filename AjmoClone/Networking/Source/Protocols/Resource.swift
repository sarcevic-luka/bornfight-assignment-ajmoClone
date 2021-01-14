//
//  Resource.swift
//  Networking
//
//  Created by Luka Šarčević on 10.01.2021..
//

import Alamofire

protocol Resource {
  var endpoint: String { get }
  var method: HTTPMethod { get }
  var queryItems: [URLQueryItem] { get }
}

extension Resource {
  var url: URL {
    let baseUrl = Host.production.endpoint.appendingPathComponent(endpoint)
    guard !queryItems.isEmpty else {
      return baseUrl
    }
    return UrlQueryBuilder(url: baseUrl)
      .addQueryItems(queryItems)
      .build() ?? baseUrl
  }
  
  var method: HTTPMethod { .get }
  var queryItems: [URLQueryItem] { [] }
}
