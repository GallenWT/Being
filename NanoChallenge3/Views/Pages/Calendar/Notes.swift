//
//  Notes.swift
//  Calendar
//
//  Created by Muhammad Rasyad Caesarardhi on 15/07/24.
//

import Foundation

struct Notes: Identifiable {
    var id: String
    var date: Date
    var text: String

    // MARK: - Show Date as Text

    static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }()

    // MARK: - Show start and end times as Text

    static var dailyTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
}
