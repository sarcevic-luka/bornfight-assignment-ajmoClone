//
//  VenueCategory.swift
//  Model
//
//  Created by Luka Šarčević on 12.01.2021..
//

import Foundation

public struct VenueCategory {
  public let id: Int
  public let image: Int
  public let name: Int
}

extension VenueCategory: Decodable { }
