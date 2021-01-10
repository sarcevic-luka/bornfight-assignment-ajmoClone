//
//  Router.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 09.01.2021..
//

import Foundation
import UIKit

protocol Router: class {
  associatedtype ViewController: UIViewController
  var viewController: ViewController? { get }
}

extension Router {
  func showModally(scene: UIViewController) {
    scene.modalPresentationCapturesStatusBarAppearance = true
    scene.modalPresentationStyle = .fullScreen

    if #available(iOS 13.0, *) {
      scene.isModalInPresentation = true
    }

    viewController?.present(scene, animated: true, completion: nil)
  }
}
