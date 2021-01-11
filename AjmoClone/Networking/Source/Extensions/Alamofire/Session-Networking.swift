//
//  Session-Networking.swift
//  Networking
//
//  Created by Luka Šarčević on 10.01.2021..
//

import Foundation
import Alamofire

extension Session {
  func request(resource: Resource,
               parameters: Parameters? = nil,
               encoding: ParameterEncoding = URLEncoding.default,
               interceptor: RequestInterceptor? = nil,
               requestModifier: RequestModifier? = nil) -> DataRequest {
    request(resource.url,
            method: resource.method,
            parameters: parameters,
            encoding: encoding,
            headers: nil,
            interceptor: interceptor,
            requestModifier: requestModifier)
  }
}
