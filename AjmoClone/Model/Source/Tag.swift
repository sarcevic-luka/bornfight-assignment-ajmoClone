//
//  Tag.swift
//  Model
//
//  Created by Luka Šarčević on 12.01.2021..
//

public struct Tag {
  public let id: Int
  public let color: String
  public let tagGroupId: Int
  public let name: String

  private enum CodingKeys: String, CodingKey {
    case id
    case color
    case tagGroupId = "tag_group_id"
    case name
  }
}

extension Tag: Decodable { }
