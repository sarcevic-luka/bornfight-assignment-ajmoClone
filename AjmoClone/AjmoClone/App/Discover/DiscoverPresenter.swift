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
  func onRefreshControlRefresh()
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
    print(indexPath)
    #warning("Implementation would go here")
  }
  
  func onRefreshControlRefresh() {
    fetchAndPresentDiscoverDetails()
  }
}

private extension DiscoverPresenter {
  func fetchAndPresentDiscoverDetails() {
    interactor?.fetchDiscoverDetails()
      .then { [weak self] news, venues in
        let dataSource = DiscoverDataSource(newsList: news, venuesData: venues)
        dataSource.buildSections()
        dataSource.setLocationManager()
        self?.view?.displayDiscoveryDetails(using: dataSource)
      }
      .catch { [weak self] _ in self?.view?.displayGenericErrorMessagePopup() }
      .always { [weak self] in self?.view?.displayRefreshControlRefreshComplete() }
  }
}
