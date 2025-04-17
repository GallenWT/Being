//
//  JournalViewModel.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 15/07/24.
//

import Foundation
import SwiftData
import UIKit

class JournalViewModel: ObservableObject {
    var modelContext: ModelContext?

    @Published var todayJournalList: [TodayJournal] = []
    @Published var todayJournal: TodayJournal? = nil
    @Published var todayJournalCheck: [Bool] = [false, false, false]
    @Published var isAlreadyWriting: Bool = false
    @Published var weeklyAnxietyLogDate: [Date] = [
        getDateBySubstracting(substractor: -6),
        getDateBySubstracting(substractor: -5),
        getDateBySubstracting(substractor: -4),
        getDateBySubstracting(substractor: -3),
        getDateBySubstracting(substractor: -2),
        getDateBySubstracting(substractor: -1),
        getDateBySubstracting(substractor: 0),
    ]
    @Published var weeklyAnxietyLogStatus: [ImageResource] = [
        .emoHappy,
        .emoHappy,
        .emoFreeze,
        .emoAnxiety,
        .emoAnxiety,
        .emoFreeze,
        .emoBlank,
    ]
    @Published var weeklyDateWithEmotionDict: [Date: Emotion] = [:]
    @Published var selectedDateJournal: TodayJournal? = nil

    func putAllJournal() {
        guard let modelContext = modelContext else {
            print("model context has not been initialized in JournalViewModel")
            return
        }

        guard let journalList = ModelContextManager.fetchAllJournals(modelContext: modelContext) else {
            print("journal list failed to be fetched")
            return
        }

        self.todayJournalList = journalList
    }

    func putTodayJournal() {
        guard let modelContext = modelContext else {
            print("model context has not been initialized in JournalViewModel")
            return
        }

        let fetchedTodayJournal = ModelContextManager.fetchTodayJournal(modelContext: modelContext)
        if fetchedTodayJournal == nil {
            self.todayJournal = nil
            return
        } else {
            self.todayJournal = fetchedTodayJournal
        }
    }

    func putTodayCheck() {
        self.putTodayJournal()
        if self.todayJournal == nil {
            self.isAlreadyWriting = false
            return
        }
        if self.todayJournal?.morningJournal != nil {
            self.todayJournalCheck[0] = true
            self.isAlreadyWriting = true
        }

        if self.todayJournal?.anxietyJournal.count != 0 {
            self.todayJournalCheck[1] = true
            self.isAlreadyWriting = true
        }

        if self.todayJournal?.eveningJournal != nil {
            self.todayJournalCheck[2] = true
            self.isAlreadyWriting = true
        }
    }

    func loadWeeklyLogs() {
        self.putAllJournal()

        for note in self.todayJournalList {
            print(note)
            self.weeklyDateWithEmotionDict.updateValue(note.status!, forKey: note.date)
        }

        for (index, date) in self.weeklyAnxietyLogDate.enumerated() {
            if let emotion = weeklyDateWithEmotionDict.first(where: { Calendar.current.isDate($0.key, inSameDayAs: date) })?.value {
//            if let emotion = weeklyDateWithEmotionDict[date] {
                self.weeklyAnxietyLogStatus[index] = imageResource(for: emotion)
            } else {
                self.weeklyAnxietyLogStatus[index] = imageResource(for: .none)
            }
        }

        func imageResource(for emotion: Emotion) -> ImageResource {
            switch emotion {
            case .happy:
                return .emoHappy
            case .anxiety:
                return .emoAnxiety
            case .none:
                return .emoFreeze
            }
        }
    }

    func putSelectedDateJournal(date: Date) {
        guard let modelContext = modelContext else {
            print("model context has not been initialized in JournalViewModel")
            return
        }

        let fetchedTodayJournal = ModelContextManager.fetchJournalBasedOnDate(modelContext: modelContext, date: date)
        if fetchedTodayJournal == nil {
            self.selectedDateJournal = nil
            return
        } else {
            self.selectedDateJournal = fetchedTodayJournal
        }
    }
}
