//
//  DiscoverInteractor.swift
//  AjmoClone
//
//  Created Luka Šarčević on 11.01.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Networking
import Model
import Promises

protocol DiscoverBusinessLogic: class {
  func fetchDiscoverDetails() -> Promise<([News], Venues)>
}

class DiscoverInteractor {
  private let discoverNetworkService: DiscoverNetworkServiceProtocol

  init(discoverNetworkService: DiscoverNetworkServiceProtocol = DiscoverNetworkService()) {
    self.discoverNetworkService = discoverNetworkService
  }

}

// MARK: - DiscoverBusinessLogic
extension DiscoverInteractor: DiscoverBusinessLogic {
  func fetchDiscoverDetails() -> Promise<([News], Venues)> {
    discoverNetworkService.getDiscoverDetails()
  }
}
