//
//  DiscoverRouter.swift
//  AjmoClone
//
//  Created Luka Šarčević on 11.01.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DiscoverRoutingLogic: class { }

protocol DiscoverRouterDelegate: class { }

class DiscoverRouter {
  weak var viewController: DiscoverViewController?
  weak var delegate: DiscoverRouterDelegate?

  static func createModule(delegate: DiscoverRouterDelegate?) -> DiscoverViewController {
    let view = DiscoverViewController(nibName: nil, bundle: nil)
    let interactor = DiscoverInteractor()
    let router = DiscoverRouter()
    router.delegate = delegate
    router.viewController = view
    let presenter = DiscoverPresenter(interface: view, interactor: interactor, router: router)
    view.presenter = presenter
    return view
  }
}

// MARK: - DiscoverRoutingLogic
extension DiscoverRouter: DiscoverRoutingLogic { }
