//
//  UIColor-AjmoClone.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 13.01.2021..
//

import UIKit

extension UIColor {
  var isLight: Bool {
    var white: CGFloat = 0
    getWhite(&white, alpha: nil)
    return white > 0.5
  }
}
