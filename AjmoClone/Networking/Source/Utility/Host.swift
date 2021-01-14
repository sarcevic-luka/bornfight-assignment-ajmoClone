//
//  Host.swift
//  Networking
//
//  Created by Luka Šarčević on 10.01.2021..
//

// swiftlint:disable force_unwrapping

import Foundation

enum Host: String {
  case production = "https://api.ajmo.hr/v3/"
}

extension Host {
  var endpoint: URL {
    URL(string: self.rawValue)!
  }
}
