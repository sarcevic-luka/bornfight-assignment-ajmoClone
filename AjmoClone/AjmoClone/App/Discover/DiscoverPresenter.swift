//
//  DiscoverPresenter.swift
//  AjmoClone
//
//  Created Luka Šarčević on 11.01.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol DiscoverViewPresentingLogic: class {
  func onViewLoaded()
  func onHeaderViewAllNewsTapped()
  func onItemSelected(at indexPath: IndexPath)
}

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
extension DiscoverPresenter: DiscoverViewPresentingLogic {
  func onViewLoaded() {
    fetchAndPresentDiscoverDetails()
  }
  
  func onHeaderViewAllNewsTapped() {
    #warning("Implementation would go here")
  }
  
  func onItemSelected(at indexPath: IndexPath) {
    #warning("Implementation would go here")
  }
}

private extension DiscoverPresenter {
  func fetchAndPresentDiscoverDetails() {
    interactor?.fetchDiscoverDetails()
      .then { news, venues in
        
      }
  }
}
