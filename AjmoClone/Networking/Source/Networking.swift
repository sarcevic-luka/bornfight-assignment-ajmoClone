//
//  Networking.swift
//  Networking
//
//  Created by Luka Šarčević on 10.01.2021..
//

import Foundation
import Alamofire

public final class Networking {
  internal static let gixonSession = Alamofire.Session(configuration: URLSessionConfiguration.default)
}
