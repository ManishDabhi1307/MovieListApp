//
//  DateFormatter+CustomFormatter.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 07/08/22.
//

import Foundation

extension DateFormatter {
    static private let customDateFormatter = DateFormatter()

    static func string(from date: Date, format: String) -> String {
        customDateFormatter.dateFormat = format
        return customDateFormatter.string(from: date)
    }

    static func date(from string: String, format: String) -> Date? {
        customDateFormatter.dateFormat = format
        return customDateFormatter.date(from: string)
    }
}
