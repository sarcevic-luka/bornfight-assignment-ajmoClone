//
//  DateFormatter.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 13.01.2021..
//

import Foundation

final class CalendarDateFormatter {
  enum DateFormat: String {
    case dayMonthYearDoted = "yyyy'.MM'.dd"
  }

  private static var dateFormatter = DateFormatter()
}

extension CalendarDateFormatter {
  func string(from date: Date, using format: DateFormat) -> String {
    Self.dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: format.rawValue, options: 0, locale: Locale.current)
    return Self.dateFormatter.string(from: date)
  }
}
