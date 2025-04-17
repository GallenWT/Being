//
//  MorningJournalingManagerViewModel.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 17/07/24.
//

import Foundation
import SwiftData

let morningPreparationPromptCount = 4

class MorningJournalingManagerViewModel: ObservableObject, JournalWriteable {
    var modelContext: ModelContext?
    
    @Published var noteText: [NSAttributedString] = [NSAttributedString](
        repeating: NSAttributedString(string: ""),
        count: morningPreparationPromptCount
    )
    
    @Published var notePrompt: [String] = [
        String(localized: "Do you remember the first thought you had this morning? Keep a list."),
        String(localized: "What do you plan to do today?"),
        String(localized: "What’s the most important thing you want to focus on today?"),
        String(localized: "What does your perfect day look like?")
    ]
    
    func finishWritingSection() {
        guard let modelContext = modelContext else {
            print("Model context isn't initialized at Morning Journal View Model")
            return
        }
    
        guard let fetchedTodayJournal = ModelContextManager.fetchTodayJournal(modelContext: modelContext) else {
            print("Today's journal not found in Morning journal view model")
            return
        }
        
        let currentMorningJournal = JournalContainer(journalType: .morning, todayJournal: fetchedTodayJournal)
        
        for i in stride(from: 0, to: morningPreparationPromptCount, by: 1) {
            let data = convertAttributedStringToArchivedData(noteText[i])
            let note = Note(sequence: i, prompt: notePrompt[i], encodedText: data, owner: currentMorningJournal)
            currentMorningJournal.notes.append(note)
        }

        let currentDate = Date()
        let calendar = Calendar.current
        
        if calendar.isDate(fetchedTodayJournal.date, inSameDayAs: currentDate) {
            fetchedTodayJournal.morningJournal = currentMorningJournal
        }
        
    }
    
    
}
