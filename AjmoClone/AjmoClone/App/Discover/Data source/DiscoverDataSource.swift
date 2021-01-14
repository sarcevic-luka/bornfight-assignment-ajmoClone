//
//  DiscoverDataSource.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 13.01.2021..
//

import UIKit
import CoreLocation
import Model

enum DiscoverDataSourceItem {
  case promo(PromoCell.ViewModel)
  case news(NewsCell.ViewModel)
  case venue(VenueCell.ViewModel)
  case venueTag(VenueTagCell.ViewModel)
  case venueCategory(VenueCategoryCell.ViewModel)
}

enum DiscoverDataSourceSection: SectionProtocol {
  enum Proxy {
    case promo
    case news
    case venue(title: String)
    case venueTag
    case venueCategory
    
    var title: String? {
      switch self {
      case .promo:
        return "Discover"
      case .news:
        return "What's up?"
      case .venue(let title):
        return title
      case .venueTag:
        return nil
      case .venueCategory:
        return "Venues"
      }
    }
  }
  
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

class DiscoverDataSource: NSObject, DataSourceProtocol {
  private let news: [News]
  private let venueCategories: [VenueCategory]
  private let customPicks: [Pick]
  private let maxNumberOfItemsShown = 8
  private var currentLocation: CLLocation?
  private let dateFormatter = CalendarDateFormatter()
  private(set) lazy var sections = [DiscoverDataSourceSection]()
  private(set) var locationManager = CLLocationManager()
  
  init(newsList: [News], venuesData: Venues) {
    news = newsList
    venueCategories = venuesData.venueCategories
    customPicks = venuesData.customPicks
  }
}

extension DiscoverDataSource {
  func setLocationManager() {
    if (CLLocationManager.locationServicesEnabled())
    {
      locationManager = CLLocationManager()
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestAlwaysAuthorization()
      locationManager.startUpdatingLocation()
    }
  }
  
  func buildSections() {
    if let promoSection = createPromoSection(),
       let newsSection = createNewsSection(),
       let venueSections = createVenueAndVenueTypesSections() {
      sections.append(promoSection)
      sections.append(newsSection)
      sections.append(contentsOf: venueSections)
    }
    print(sections.count)
  }
}

extension DiscoverDataSource: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways || status == .authorizedWhenInUse {
      manager.startUpdatingLocation()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      currentLocation = location
      manager.stopUpdatingLocation()
    }
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
    .news(NewsCell.ViewModel(news.title, news.imageUrl, news.description, news.createdAt))
  }
  
  func createVenueDataItem(with venue: Venue) -> DiscoverDataSourceItem {
    let distance = distanceFromTo(location: CLLocation(latitude: venue.lat, longitude: venue.lon))
    return .venue(VenueCell.ViewModel(venue.name, venue.pictureUrl, venue.subtitle, distance))
  }
  
  func createVenueTagsDataItem(with venueTag: Tag) -> DiscoverDataSourceItem {
    .venueTag(VenueTagCell.ViewModel(venueTag.name, UIColor(hex: venueTag.color)))
  }
  
  // Quite ugly, meh.
  //  func indexPath(forItemWithTitle title: String) -> IndexPath? {
  //    guard let indexOf = sections.firstIndex(where: { section in
  //      switch section {
  //      case .about(_, let item), .genre(_, let item), .instruments(_, let item), .rules(_, let item):
  //        if case let ArtistProfileDataSourceItem.expandableText(viewModel) = item, viewModel.title == title {
  //          return true
  //        } else {
  //          return false
  //        }
  //      default:
  //        return false
  //      }
  //    }) else {
  //      return nil
  //    }
  //    return IndexPath(row: 0, section: indexOf)
  //  }
}

private extension DiscoverDataSource {
  func flattenedArray(array: [Any]) -> [DiscoverDataSourceSection] {
    var myArray = [DiscoverDataSourceSection]()
    for element in array {
      if let element = element as? DiscoverDataSourceSection {
        myArray.append(element)
      }
      if let element = element as? [DiscoverDataSourceSection] {
        let result = flattenedArray(array: element)
        for i in result {
          myArray.append(i)
        }
      }
    }
    return myArray
  }
  
  /// Calculates distance from current location
  /// - Parameter location: venue location
  /// - Returns: distance in km
  func distanceFromTo(location: CLLocation) -> String {
    guard let curentPosition = currentLocation else {
      return ""
    }
    return "\(curentPosition.distance(from: location) / 1000)"
  }
}
