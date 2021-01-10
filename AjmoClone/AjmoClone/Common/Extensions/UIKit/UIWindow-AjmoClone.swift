//
//  UIWindow-AjmoClone.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 09.01.2021..
//

import UIKit
import Promises

extension UIWindow {
  @discardableResult
  func setRootViewController(_ rootViewController: UIViewController, animated: Bool) -> Promise<Void> {
    guard let snapshot = snapshotView(afterScreenUpdates: true) else {
      return Promise(())
    }
    guard animated else {
      self.rootViewController = rootViewController
      return Promise(())
    }
    return Promise { [weak self] fullfill, _ in
      rootViewController.view.addSubview(snapshot)
      self?.rootViewController = rootViewController
      UIView.animate(withDuration: 0.3, animations: {
        snapshot.layer.opacity = 0
        snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
      }, completion: { _ in
        snapshot.removeFromSuperview()
        fullfill(())
      })
    }
  }
}

extension UIWindow {
  var topViewController: UIViewController? {
    var top = rootViewController

    while true {
      if let presented = top?.presentedViewController {
        top = presented
      } else if let nav = top as? UINavigationController {
        top = nav.visibleViewController
      } else if let tab = top as? UITabBarController {
        top = tab.selectedViewController
      } else {
        break
      }
    }
    return top
  }
}
