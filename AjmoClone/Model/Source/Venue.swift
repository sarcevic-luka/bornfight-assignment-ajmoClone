//
//  Venue.swift
//  Model
//
//  Created by Luka Šarčević on 12.01.2021..
//

import Foundation

public struct Venue {
  public let id: Int
  public let subtitle: String
  public let pictureUrl: URL?
  public let venueCategories: [VenueCategory]
  public let primaryTagGroup: String
  public let allTags: Tags
  public let address: String
  public let opened: Bool
  public let web: String?
  public let telephone: String?
  public let shareLink: String
  public let city: String
  public let lat: Double
  public let lon: Double
  public let trending: Int
  public let promoted: Int
  public let bat: Int
  public let active: Int
  public let smokingArea: Int
  public let workingHours: [WorkHours]
  public let gallery: [GalleryImage]
  public let type: String
  public let name: String
  public let description: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case subtitle
    case pictureUrl = "picture_url"
    case venueCategories = "venue_categories"
    case primaryTagGroup = "primary_tag_group"
    case allTags
    case address
    case opened
    case web
    case telephone
    case shareLink = "share_link"
    case city
    case lat
    case lon
    case trending
    case promoted
    case bat
    case active
    case smokingArea = "smoking_area"
    case workingHours = "working_hours"
    case gallery
    case type
    case name
    case description
  }
}

extension Venue: Decodable { }

public extension Venue {
  struct Tags: Decodable {
    public let primaryTags: [Tag]
    public let secondaryTags: [Tag]
  }
}

public extension Venue {
  struct WorkHours: Decodable {
    public let id: Int
    public let day: Int
    public let start: String
    public let end: String
  }
}

public extension Venue {
  struct GalleryImage: Decodable {
    public let id: Int
    public let picture: URL
  }
}
