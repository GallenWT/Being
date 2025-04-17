//
//  EveningJournalWritingViewModel.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 17/07/24.
//

import Foundation
import SwiftData

let eveningPreparationPromptCount = 3

class EveningJournalWritingViewModel: ObservableObject, JournalWriteable {
    var modelContext: ModelContext?
    
    @Published var noteText: [NSAttributedString] = [NSAttributedString](
        repeating: NSAttributedString(string: ""),
        count: eveningPreparationPromptCount
    )
    
    @Published var notePrompt: [String] = [
        String(localized: "What went well today, what are 3 things that happened today that you are grateful for?"),
        String(localized: "What could have gone better today?"),
        String(localized: "What can you learn from today so that you can be better tomorrow?")
    ]
    
    @Published var status: Emotion = .happy
    
    func finishWritingSection() {
        guard let modelContext = modelContext else {
            print("Model context isn't initialized at Evening Journal View Model")
            return
        }
        
        guard let fetchedTodayJournal = ModelContextManager.fetchTodayJournal(modelContext: modelContext) else {
            print("Today's journal not found in Evening journal view model")
            return
        }
        
        let currentEveningJournal = JournalContainer(journalType: .evening, todayJournal: fetchedTodayJournal)
        
        for i in stride(from: 0, to: eveningPreparationPromptCount, by: 1) {
            let data = convertAttributedStringToArchivedData(noteText[i])
            let note = Note(sequence: i, prompt: notePrompt[i], encodedText: data, owner: currentEveningJournal)
            currentEveningJournal.notes.append(note)
        }
        
        // save the note to evening if it still the same day
        let currentDate = Date()
        let calendar = Calendar.current
        
        if calendar.isDate(fetchedTodayJournal.date, inSameDayAs: currentDate) {
            fetchedTodayJournal.date = currentDate
            fetchedTodayJournal.eveningJournal = currentEveningJournal
            fetchedTodayJournal.status = status
        }
        
    }
    
    
}
