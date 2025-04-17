//
//  TodayJournal.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 15/07/24.
//

import Foundation
import SwiftData

@Model
final class TodayJournal {
    let id: UUID = UUID()
    var date: Date
    @Relationship(deleteRule: .cascade, inverse: \JournalContainer.todayJournal) var morningJournal: JournalContainer?
    @Relationship(deleteRule: .cascade, inverse: \JournalContainer.todayJournal) var eveningJournal: JournalContainer?
    @Relationship(deleteRule: .cascade, inverse: \JournalContainer.todayJournal) var anxietyJournal: [JournalContainer]
    var status: Emotion?

    init(date: Date, morningJournal: JournalContainer? = nil, eveningJournal: JournalContainer? = nil, anxietyJournal: [JournalContainer]? = nil, status: Emotion?) {
        self.date = date
        self.morningJournal = morningJournal
        self.eveningJournal = eveningJournal
        self.anxietyJournal = []
        self.status = status
    }
}
