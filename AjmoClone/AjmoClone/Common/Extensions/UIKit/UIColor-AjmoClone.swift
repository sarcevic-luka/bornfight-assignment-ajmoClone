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
  
  convenience init(hex: String, alpha: CGFloat = 1.0) {
    var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    
    if hexFormatted.hasPrefix("#") {
      hexFormatted = String(hexFormatted.dropFirst())
    }
    
    assert(hexFormatted.count == 6, "Invalid hex code used.")
    
    var rgbValue: UInt64 = 0
    Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
    
    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }
}
//    struct Blue {
//        static let cometLightBlue = UIColor(netHex: 0x4B94EE)
//        static let cometUltralightBlue = UIColor(netHex: 0xDFEEFE)
//        static let cometActiveBlue = UIColor(netHex: 0xEBF4FE)
//        static let cometPassiveBlue = UIColor(netHex: 0x0096FF)
//    }
//
//    struct Gray {
//        static let cometUltralightGray = UIColor(netHex: 0xC0C0C0)
//        static let cometLightGray = UIColor(netHex: 0xEEEFF1)
//        static let cometMediumGray = UIColor(netHex: 0xEEEFF1)
//        static let cometDarkGray = UIColor(netHex: 0x808591)
//    }
//
//    struct Green {
//        static let cometGreen = UIColor(netHex: 0x90CD33)
//    }
