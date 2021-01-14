//
//  DateFormatter.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 13.01.2021..
//

import Foundation

final class TimeDateFormatter {
  enum DateFormat: String {
    case dayMonthYearDoted = "dd.MM.yyyy"
  }

  private static var dateFormatter = DateFormatter()
}

extension TimeDateFormatter {
  func string(from date: Date, using format: DateFormat) -> String {
    Self.dateFormatter.dateFormat = format.rawValue
    return Self.dateFormatter.string(from: date)
  }
}
