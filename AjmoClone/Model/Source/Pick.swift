//
//  Pick.swift
//  Model
//
//  Created by Luka Šarčević on 13.01.2021..
//

import Foundation

public struct Pick {
  public let id: Int
  public let order: Int
  public let tags: [Tag]
  public let type: String
  public let items: [Venue]
  public let title: String
}

extension Pick: Decodable { }
