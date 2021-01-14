//
//  DiscoverDataSource.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 13.01.2021..
//

import UIKit
import CoreLocation
import MapKit
import Model

enum DiscoverDataSourceItem {
  case promo(PromoCell.ViewModel)
  case news(NewsCell.ViewModel)
  case venue(VenueCell.ViewModel)
  case venueTag(VenueTagCell.ViewModel)
  case venueCategory(VenueCategoryCell.ViewModel)
}

enum DiscoverDataSourceSection: SectionProtocol {  
  case promo(String, DiscoverDataSourceItem)
  case news(String, [DiscoverDataSourceItem])
  case venue(String, [DiscoverDataSourceItem])
  case venueTag([DiscoverDataSourceItem])
  case venueCategory(String, [DiscoverDataSourceItem])

  var items: [DiscoverDataSourceItem] {
    switch self {
    case .promo(_, let item):
      return [item]
    case .news(_, let items), .venue(_, let items), .venueTag(let items), .venueCategory(_, let items):
      return items
    }
  }
}

class DiscoverDataSource: DataSourceProtocol {
  private var news: [News] = []
  private var venueCategories: [VenueCategory] = []
  private var customPicks: [Pick] = []
  private let maxNumberOfItemsShown = 8
  private var currentLocation: CLLocation?
  private let dateFormatter = TimeDateFormatter()
  private let distanceFormater = MKDistanceFormatter()

  private(set) lazy var sections = [DiscoverDataSourceSection]()
  
  init() {
    buildSections()
  }
}

extension DiscoverDataSource {
  func buildSections() {
    sections.removeAll()
    if let promoSection = createPromoSection() {
      sections.append(promoSection)
    }
    if let newsSection = createNewsSection() {
      sections.append(newsSection)
    }
    if let venueSections = createVenueAndVenueTypesSections() {
      sections.append(contentsOf: venueSections)
    }
  }
  
  func set(newsList: [News], venuesData: Venues) {
    news = newsList
    venueCategories = venuesData.venueCategories
    customPicks = venuesData.customPicks
    buildSections()
  }
  
  func setLocation(location: CLLocation) {
    currentLocation = location
    buildSections()
  }
}

// MARK: - DiscoverDataSourceSection creation
private extension DiscoverDataSource {
  // This is "wrong" - there was another API call (with isPromoted=1 param)
  // but for this demonstration I chose to use first item from already
  // existing array of news, mainly for layout testing
  func createPromoSection() -> DiscoverDataSourceSection? {
    guard let promotedNews = news.first else {
      return nil
    }
    return .promo("Discover", createPromoDataItem(with: promotedNews))
  }

  func createNewsSection() -> DiscoverDataSourceSection? {
    guard !news.isEmpty else { return nil }
    let maxNumber = min(maxNumberOfItemsShown, news.count)
    return .news("What's up?", news[0..<maxNumber].map(createNewsDataItem))
  }

  func createVenueAndVenueTypesSections() -> [DiscoverDataSourceSection]? {
    guard !customPicks.isEmpty else { return nil }
    var arrangedVenusPairs: [DiscoverDataSourceSection] = []
    for venuePair in customPicks {
      arrangedVenusPairs += createVenueAndVenueTypesSection(for: venuePair)
    }
    return arrangedVenusPairs
  }

  func createVenueAndVenueTypesSection(for venuePick: Pick) -> [DiscoverDataSourceSection] {
    let venueItems = venuePick.items
    let maxVenueNumber = min(maxNumberOfItemsShown, venueItems.count)
    let venueDataSourceItems: [DiscoverDataSourceItem] = venueItems[0..<maxVenueNumber].map(createVenueDataItem)
    let venuesInSection: DiscoverDataSourceSection = .venue(venuePick.title, venueDataSourceItems)

    let tagItems = venuePick.tags
    let maxTagNumber = min(maxNumberOfItemsShown, tagItems.count)
    let tagsDataSourceItems: [DiscoverDataSourceItem] = tagItems[0..<maxTagNumber].map(createVenueTagsDataItem)
    let tagsInSection: DiscoverDataSourceSection = .venueTag(tagsDataSourceItems)

    return [venuesInSection, tagsInSection]
  }
}

// MARK: - DiscoverDataSourceItem creation
private extension DiscoverDataSource {
  func createPromoDataItem(with news: News) -> DiscoverDataSourceItem {
    return .promo(PromoCell.ViewModel(news.highlightedText, news.imageUrl, news.title, news.caption))
  }

  func createNewsDataItem(with news: News) -> DiscoverDataSourceItem {
    .news(NewsCell.ViewModel(news.title, news.imageUrl, news.caption, news.createdAt))
  }

  func createVenueDataItem(with venue: Venue) -> DiscoverDataSourceItem {
    let distance = distanceFromTo(location: CLLocation(latitude: venue.lat, longitude: venue.lon))
    return .venue(VenueCell.ViewModel(venue.name, venue.pictureUrl, venue.subtitle, distance))
  }

  func createVenueTagsDataItem(with venueTag: Tag) -> DiscoverDataSourceItem {
    .venueTag(VenueTagCell.ViewModel(venueTag.name, UIColor(hex: venueTag.color)))
  }
}

// This could also go to dedicated manager
private extension DiscoverDataSource {
  /// Calculates distance from current location
  /// - Parameter location: venue location
  /// - Returns: distance in km
  func distanceFromTo(location: CLLocation) -> String {
    guard let curentPosition = currentLocation else {
      return ""
    }
    distanceFormater.unitStyle = .abbreviated
    let distance = curentPosition.distance(from: location)
    distanceFormater.string(fromDistance: distance)
    return distanceFormater.string(fromDistance: distance)
  }
}
