//
//  ModelManager.swift
//  NanoChallenge3
//
//  Created by Muhammad Rasyad Caesarardhi on 17/07/24.
//

import Foundation
import SwiftData

class ModelContextManager {
    static func fetchAllJournals(modelContext: ModelContext) -> [TodayJournal]? {
        let descriptor = FetchDescriptor<TodayJournal>()

        guard let fetchedJournals = try? modelContext.fetch(descriptor) else {
            print("failed to fetch")
            return nil
        }

        return fetchedJournals
    }

    static func fetchTodayJournal(modelContext: ModelContext) -> TodayJournal? {
        guard let fetchedJournals = fetchAllJournals(modelContext: modelContext) else {
            return nil
        }

        let filteredFetchedJournal = fetchedJournals.filter {
            Calendar.current.isDate($0.date, inSameDayAs: Date())
        }

        guard let todayJournalFetched = filteredFetchedJournal.first else {
            return nil
        }

        return todayJournalFetched
    }

    static func fetchJournalBasedOnDate(modelContext: ModelContext, date: Date) -> TodayJournal? {
        guard let fetchedJournals = fetchAllJournals(modelContext: modelContext) else {
            return nil
        }

        let filteredFetchedJournal = fetchedJournals.filter {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }

        guard let journalFetched = filteredFetchedJournal.first else {
            return nil
        }

        return journalFetched
    }
}
