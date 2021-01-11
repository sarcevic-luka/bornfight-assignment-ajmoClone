//
//  DiscoverPresenter.swift
//  AjmoClone
//
//  Created Luka Šarčević on 11.01.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol DiscoverViewPresentingLogic: class { }

class DiscoverPresenter {
  var interactor: DiscoverBusinessLogic?
  weak private var view: DiscoverDisplayLogic?
  private let router: DiscoverRoutingLogic
  
  init(interface: DiscoverDisplayLogic, interactor: DiscoverBusinessLogic?, router: DiscoverRoutingLogic) {
    self.view = interface
    self.interactor = interactor
    self.router = router
  }
}

// MARK: - DiscoverViewPresentingLogic
extension DiscoverPresenter: DiscoverViewPresentingLogic { }
