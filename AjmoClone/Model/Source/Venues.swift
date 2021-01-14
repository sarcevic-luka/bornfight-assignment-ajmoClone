
//  Venues.swift
//  Model
//
//  Created by Luka Šarčević on 12.01.2021..
//

import Foundation

public struct Venues {
  public let venueCategories: [VenueCategory]
  public let customPicks: [Pick]
}

extension Venues: Decodable { }
