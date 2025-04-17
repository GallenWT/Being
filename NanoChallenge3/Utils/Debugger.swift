//
//  Debugger.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 17/07/24.
//

import Foundation

struct Debugger {
    static func checkTodayJournalAtHome(_ viewModel: JournalViewModel, check: JournalType){
        
        // DEBUG
        guard let todayJournal = viewModel.todayJournal else {
            print("Today journal hasn't been put in home view")
            return
        }
        
        guard let status = todayJournal.status else {
            print("No status today")
            return
        }
        print("Today's status: \(status.rawValue)")
        
        switch check {
        case .morning:
            guard let journal = todayJournal.morningJournal else {
                print("morning Journal hasn't been initialized")
                return
            }
            print("Morning journal is initialized")
            printNoteData(journal: journal)
            
        case .evening:
            guard let journal = todayJournal.eveningJournal else {
                print("evening Journal hasn't been initialized")
                return
            }
            print("Evening journal is initialized")
            printNoteData(journal: journal)
            
        case .anxiousJournal:
            if todayJournal.anxietyJournal.isEmpty {
                print("Today journal anxiety is empty")
                return
            }
            for journal in todayJournal.anxietyJournal {
                printNoteData(journal: journal)
            }
        }
    }
    
    static private func printNoteData(journal: JournalContainer){
        print("\(journal.journalType) data: ")
        let notes = journal.notes.sorted { note1, note2 in
            note1.sequence < note2.sequence
        }
        
        for note in notes {
            if let text = convertDataToAttributedString(note) {
                print(note.prompt)
                print(text.string)
            }
        }
    }
}
