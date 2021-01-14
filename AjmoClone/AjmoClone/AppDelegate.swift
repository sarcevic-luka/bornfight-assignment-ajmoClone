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
    StartupProcessService()
      .execute(process: AppearanceCustomisationStartupProcess())

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = appRouter.initialViewController()
    window?.makeKeyAndVisible()
    return true
  }
}
