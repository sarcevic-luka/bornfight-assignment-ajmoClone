//
//  AppearanceCustomisationStartupProcess.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 14.01.2021..
//

import Foundation
import UIKit

final class AppearanceCustomisationStartupProcess: StartupProcess {
  func run(completion: @escaping (Bool) -> Void) {
    UITabBar.appearance().barTintColor = .white
    UITabBar.appearance().tintColor = UIColor.Yellow.golden
    UITabBar.appearance().unselectedItemTintColor = .black
    UITabBar.appearance().isTranslucent = false
    
    UINavigationBar.appearance().barTintColor = UIColor.Blue.lightBlue
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().titleTextAttributes = [
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .medium) as Any,
      NSAttributedString.Key.foregroundColor: UIColor.Yellow.golden
    ]

    completion(true)
  }
}
