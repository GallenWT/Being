//
//  DateHelper.swift
//  NanoChallenge3
//
//  Created by Muhammad Rasyad Caesarardhi on 14/07/24.
//

import Foundation

// helper untuk mengambil yesterday's date
func getYesterdayDate() -> Date {
    return getDateBySubstracting(substractor: -1)
}

func getDateBySubstracting(substractor: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: substractor, to: Date()) ?? Date()
}

func getTodayDate() -> Date {
    return Date()
}
