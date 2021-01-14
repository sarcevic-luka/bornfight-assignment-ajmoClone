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
  func onRefreshControlRefresh()
}

class DiscoverPresenter {
  var interactor: DiscoverBusinessLogic?
  weak private var view: DiscoverDisplayLogic?
  private let router: DiscoverRoutingLogic
  private var dataSource: DiscoverDataSource

  init(interface: DiscoverDisplayLogic, interactor: DiscoverBusinessLogic?, router: DiscoverRoutingLogic) {
    self.view = interface
    self.dataSource = DiscoverDataSource()
    self.interactor = interactor
    self.router = router
  }
}

// MARK: - DiscoverViewPresentingLogic
extension DiscoverPresenter: DiscoverViewPresentingLogic {
  func onViewLoaded() {
    fetchAndPresentDiscoverDetails()
    interactor?.locationChanged(handler: { [weak self] location in
      guard let strongSelf = self else { return }
      strongSelf.dataSource.setLocation(location: location)
      strongSelf.view?.displayDiscoveryDetails(using: strongSelf.dataSource)
    })
  }

  func onRefreshControlRefresh() {
    fetchAndPresentDiscoverDetails()
  }
}

private extension DiscoverPresenter {
  func fetchAndPresentDiscoverDetails() {
    interactor?.fetchDiscoverDetails()
      .then { [weak self] news, venues in
        guard let strongSelf = self else { return }
        strongSelf.dataSource.set(newsList: news, venuesData: venues)
        strongSelf.view?.displayDiscoveryDetails(using: strongSelf.dataSource)
      }
      .catch { [weak self] _ in self?.view?.displayGenericErrorMessagePopup() }
      .always { [weak self] in self?.view?.displayRefreshControlRefreshComplete() }
  }
}
