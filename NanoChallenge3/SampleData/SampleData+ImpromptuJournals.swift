/*
 See the LICENSE.txt file for this sample’s licensing information.

 Abstract:
 An extension that creates animal category instances for use as sample data.
 */

import Foundation
import SwiftData

// TODO: Boleh dijelasin gimana cara pakenya
extension TodayJournal {
    //    1. tambahin data dummy di sini aja

//    ini contoh pake DATA
//    static let impromptuJournal1 = ImpromptuJournals(journalId: 1, createdTimestamp: getYesterdayDate(), text: [.firstQuestion: Data(base64Encoded: "aaaaa") ?? Data(), .secondQuestion: Data(base64Encoded: "aaaaa") ?? Data(), .thirdQuestion: Data(base64Encoded: "aaaaa") ?? Data()])

//    ini contoh pake STRING DICT
//    static let impromptuJournal1 = ImpromptuJournals(journalId: 1, createdTimestamp: getYesterdayDate(), text: [.firstQuestion: "aaaaaa", .secondQuestion: "aaaaaa", .thirdQuestion: "aaaaaaa"])

//    ini contoh pake STRING
    static let impromptuJournal1 = TodayJournal(date: getYesterdayDate(), morningJournal: nil, eveningJournal: nil, anxietyJournal: [], status: .anxiety)
//    static let impromptuJournal2 = TodayJournal(date: Date(), morningJournal: nil, eveningJournal: nil, anxietyJournal: [JournalContainer(journalType: .anxiousJournal, todayJournal: impromptuJournal1)], status: .anxiety)
    static let impromptuJournal3 = TodayJournal(date: getDateBySubstracting(substractor: -2), morningJournal: nil, eveningJournal: nil, anxietyJournal: [], status: .anxiety)
    static let impromptuJournal4 = TodayJournal(date: getDateBySubstracting(substractor: -3), morningJournal: nil, eveningJournal: nil, anxietyJournal: [], status: .anxiety)

//    static let notes1 = Note(encodedText: convertAttributedStringToArchivedData(NSAttributedString(string: "aaaa")), owner: impromptuJournal1.anxietyJournal?.first)

    static func insertSampleData(modelContext: ModelContext) {
        // 2. tambahin modelContext.insert(dataBaru)
        modelContext.insert(impromptuJournal1)
//        modelContext.insert(impromptuJournal2)
        modelContext.insert(impromptuJournal3)
        modelContext.insert(impromptuJournal4)
    }

    static func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: TodayJournal.self)
            insertSampleData(modelContext: modelContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
