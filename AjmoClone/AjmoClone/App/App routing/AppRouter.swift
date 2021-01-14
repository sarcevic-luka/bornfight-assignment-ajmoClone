//
//  AppRouter.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 09.01.2021..
//

import Foundation
import UIKit

// This class is used to handle user states (login, logout, ect.), push notifications and similar events.
final class AppRouter {
    init() { }
}

// MARK: Routing
extension AppRouter: Router {
  var viewController: UIViewController? {
    UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.topViewController
  }
}

extension AppRouter {
  func initialViewController() -> UIViewController {
    return UINavigationController(rootViewController: DiscoverRouter.createModule(delegate: nil))
  }
}
