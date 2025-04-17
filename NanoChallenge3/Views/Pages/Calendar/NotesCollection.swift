////
////  Achievement.swift
////  Calendar
////
////  Created by Muhammad Rasyad Caesarardhi on 14/07/24.
////
//
//import Foundation
//import SwiftData
//
//@Model
//class NotesCollection {
//   
//    var notes = [TodayJournal]()
//
//    // MARK: - Sample set of notes
//
//    // MARK: - To get sample Dates
//
//    static func getDateFromString(_ dateString: String) -> Date? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        guard let date = formatter.date(from: dateString) else {
//            return nil
//        }
//
//        return date
//    }
//
//    func getAnxietyStatus(on date: Date) -> AnxietyStatus {
//        let isHappy = true
//        for note in notes {
//            if Calendar.current.compare(date, to: note.date, toGranularity: .day) == .orderedSame {
//                if isHappy {
//                    return .Happy
//                } else {
//                    return .Anxiety
//                }
//            }
//        }
//        return .NotShowing
//    }
//
//    enum AnxietyStatus: Hashable, Codable {
//        case Happy, Anxiety, NotShowing
//    }
//}
