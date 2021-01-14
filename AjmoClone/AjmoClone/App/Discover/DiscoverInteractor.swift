//
//  DiscoverInteractor.swift
//  AjmoClone
//
//  Created Luka Šarčević on 11.01.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import CoreLocation
import Networking
import Model
import Promises

protocol DiscoverBusinessLogic: class {
  func fetchDiscoverDetails() -> Promise<([News], Venues)>
  func locationChanged(handler: @escaping (CLLocation) -> Void)
}

class DiscoverInteractor: NSObject {
  private let discoverNetworkService: DiscoverNetworkServiceProtocol
  private let locationManagerService = CLLocationManager()
  private var locationHandler: ((CLLocation) -> Void)?

  init(discoverNetworkService: DiscoverNetworkServiceProtocol = DiscoverNetworkService()) {
    self.discoverNetworkService = discoverNetworkService
    super.init()
    locationManagerService.delegate = self
    locationManagerService.desiredAccuracy = kCLLocationAccuracyBest
    locationManagerService.requestWhenInUseAuthorization()
  }
}

// MARK: - DiscoverBusinessLogic
extension DiscoverInteractor: DiscoverBusinessLogic {
  func fetchDiscoverDetails() -> Promise<([News], Venues)> {
    discoverNetworkService.getDiscoverDetails()
  }
  
  func locationChanged(handler: @escaping (CLLocation) -> Void) {
    locationHandler = handler
    locationManagerService.startUpdatingLocation()
  }
}

// MARK: - CLLocationManagerDelegate
extension DiscoverInteractor: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways || status == .authorizedWhenInUse {
      manager.startUpdatingLocation()
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      self.locationHandler?(location)
      manager.stopUpdatingLocation()
    }
  }
}
