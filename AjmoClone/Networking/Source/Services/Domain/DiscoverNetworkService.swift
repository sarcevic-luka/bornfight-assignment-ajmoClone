//
//  DiscoverNetworkService.swift
//  Networking
//
//  Created by Luka Šarčević on 12.01.2021..
//

import Foundation
import Model
import Promises
import Alamofire

public protocol DiscoverNetworkServiceProtocol {
  func getDiscoverDetails() -> Promise<(News, Venues)>
}

public final class DiscoverNetworkService {
  public init() { }
}

extension DiscoverNetworkService: DiscoverNetworkServiceProtocol {
  public func getDiscoverDetails() -> Promise<(News, Venues)> {
    all(getNews(), getVenues())
      .then { (news, venues) -> Promise<(News, Venues)> in
        return Promise((news, venues))
      }
  }
}

private extension DiscoverNetworkService {
  func getNews() -> Promise<News> {
    Promise { fullfill, reject in
      Networking.session
        .request(resource: DiscoverResource.getNews)
        .responseDecodable(decoder: JSONDecoder.default) { (response: DataResponse<ApiResponseContainer<News>, AFError>) in
          switch response.result {
          case .success(let container):
            fullfill(container.data)
          case .failure(let error):
            reject(error)
          }
        }
    }
  }
  
  func getVenues() -> Promise<Venues> {
    Promise { fullfill, reject in
      Networking.session
        .request(resource: DiscoverResource.getVenues)
        .responseDecodable(decoder: JSONDecoder.default) { (response: DataResponse<ApiResponseContainer<Venues>, AFError>) in
          switch response.result {
          case .success(let container):
            fullfill(container.data)
          case .failure(let error):
            reject(error)
          }
        }
    }
  }
}

