
//  Venues.swift
//  Model
//
//  Created by Luka Šarčević on 12.01.2021..
//

import Foundation

public struct Venues {
  public let venueCategories: [VenueCategory]
  public let customPicks: [Picks]
}

extension Venues: Decodable { }

public extension Venues {
  struct Picks: Decodable {
    public let id: Int
    public let order: Int
    public let tags: [Tag]
    public let type: String
    public let items: [Venue]
    public let title: String
  }
}


