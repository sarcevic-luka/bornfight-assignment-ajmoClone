//
//  SectionProtocol.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 13.01.2021..
//

import Foundation

protocol SectionProtocol {
  associatedtype Item
  var items: [Item] { get }
  var isCollapsed: Bool { get }
}

extension SectionProtocol {
  var isCollapsed: Bool {
    return false
  }

  func item(at index: Int) -> Item? {
    return items[safe: index]
  }
}
