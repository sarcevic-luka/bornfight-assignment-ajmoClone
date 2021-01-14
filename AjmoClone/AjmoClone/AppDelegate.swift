//
//  AppDelegate.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 09.01.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  private(set) lazy var appRouter = AppRouter()
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let initialViewController = appRouter.initialViewController()
    let navigationController = UINavigationController(rootViewController: initialViewController)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    return true
  }
}

