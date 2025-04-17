//
//  Document.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 15/07/24.
//

import Foundation
import SwiftData

@Model
final class JournalContainer {
    @Relationship(deleteRule: .cascade, inverse: \Note.owner) var notes: [Note]
    var journalType: JournalType
    var todayJournal: TodayJournal?

    init(journalType: JournalType, todayJournal: TodayJournal?) {
        self.notes = []
        self.journalType = journalType
        self.todayJournal = todayJournal
    }
}
