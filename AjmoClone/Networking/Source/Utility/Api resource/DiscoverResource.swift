//
//  DiscoverResource.swift
//  Networking
//
//  Created by Luka Šarčević on 12.01.2021..
//

import Foundation
import Alamofire

enum DiscoverResource: Resource {
  case getNews
  case getVenues
  
  var endpoint: String {
    switch self {
    case .getNews:
      return "news/index"
    case .getVenues:
      return "venue/dashboard"
    }
  }
}
