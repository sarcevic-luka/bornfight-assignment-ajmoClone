//
//  News.swift
//  Model
//
//  Created by Luka Šarčević on 12.01.2021..
//

import Foundation

public struct News {
  public let id: Int
  public let links: [Link]
  public let imageUrl: String
  public let shareLink: String
  public let isHighlighted: Bool
  public let caption: String
  public let isPromoted: Int
  public let highlightedText: String
  public let highlightedIcon: String
  public let highlightedColorFirst: String
  public let highlightedColorSecond: String
  public let title: String
  public let description: String?

  private enum CodingKeys: String, CodingKey {
    case id
    case links
    case imageUrl = "image_url"
    case shareLink = "share_link"
    case isHighlighted
    case caption
    case isPromoted = "is_promoted"
    case highlightedText = "highlighted_text"
    case highlightedIcon = "highlighted_icon"
    case highlightedColorFirst = "highlighted_gradient_color_first"
    case highlightedColorSecond = "highlighted_gradient_color_second"
    case title
    case description
  }
}

extension News: Decodable { }

public extension News {
  struct Link: Decodable {
    public let id: Int
    public let newsId: Int
    public let linkId: Int?
    public let linkType: String?

    private enum CodingKeys: String, CodingKey {
      case id
      case newsId = "news_id"
      case linkId = "link_id"
      case linkType = "link_type"
    }
  }
}
