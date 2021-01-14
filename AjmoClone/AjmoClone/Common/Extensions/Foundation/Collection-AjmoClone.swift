//
//  Collection-AjmoClone.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 13.01.2021..
//

import Foundation

public extension Collection {
  /** Returns the element at the specified index if it is within bounds, otherwise nil. */
  subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
