//
//  NetworkEventMonitor.swift
//  Networking
//
//  Created by Luka Šarčević on 12.01.2021..
//

import Foundation
import Alamofire

internal struct NetworkEventMonitor {
  internal let logsResponses: Bool

  internal init(logsResponses: Bool = true) {
    self.logsResponses = logsResponses
  }
}

extension NetworkEventMonitor: EventMonitor {
  internal func request(_ request: Alamofire.Request, didCreateURLRequest urlRequest: URLRequest) {
    guard let url = urlRequest.url, let method = urlRequest.method else { return }

    var log = [method.rawValue, url.absoluteString].joined(separator: " ")

    if [HTTPMethod.post, HTTPMethod.put, HTTPMethod.patch].contains(method), let body = urlRequest.httpBody, let json = String(data: body, encoding: .utf8) {
      log += "\nBody: \(json)"
    }

//    print("🌐 | \(#function) | \(log)")
  }

  internal func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
    // Uncoment when debuging
//    guard
//      logsResponses,
//      let data = response.data,
//      let object = try? JSONSerialization.jsonObject(with: data, options: []),
//      let prettyPrintedData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
//      let jsonString = String(data: prettyPrintedData, encoding: .utf8) else {
//      return
//    }
//    print("🌐 | \(#function)\nResponse: \(jsonString)")
  }

  internal func requestDidFinish(_ request: Alamofire.Request) {
    // Uncoment when debuging
//    guard
//      let urlRequest = request.request,
//      let method = urlRequest.method,
//      let response = request.response,
//      let url = request.response?.url else { return }
//    let log = [response.statusCode.description, method.rawValue, url.absoluteString].joined(separator: " ")
//    print("🌐 | \(#function) | \(log)")
  }
}
