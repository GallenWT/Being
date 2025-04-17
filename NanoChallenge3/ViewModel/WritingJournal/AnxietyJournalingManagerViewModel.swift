//
//  AnxietyJournalingViewModel.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 15/07/24.
//

import Foundation
import SwiftUI
import SwiftData

let anxietyPromptCount = 4

class AnxietyJournalingViewModelManager: ObservableObject, JournalWriteable {
    var modelContext: ModelContext?
    
    @Published var nextButtonEnabled: Bool = true
    @Published var relaxationState = RelaxationState.initial
    @Published var noteText: [NSAttributedString] = [NSAttributedString](
        repeating: NSAttributedString(string: ""),
        count: anxietyPromptCount
    )
    @Published var notePrompt: [String] = [
        String(localized: "What is making you feel anxious today?"),
        String(localized: "Write a letter to yourself."),
        String(localized: "What’s one kind or supportive thing you can say to yourself?"),
        String(localized: "What is one of your favorite memories?")
    ]
    
    func finishWritingSection(){
        guard let modelContext = modelContext else {
            print("Model context isn't initialized at Anxiety Journal View Model")
            return
        }
    
        guard let fetchedTodayJournal = ModelContextManager.fetchTodayJournal(modelContext: modelContext) else {
            print("Today's journal not found in anxiety journal view model")
            return
        }
        
        let currentAnxietyJournal = JournalContainer(journalType: .anxiousJournal, todayJournal: fetchedTodayJournal)
        
        for i in stride(from: 0, to: anxietyPromptCount, by: 1) {
            let data = convertAttributedStringToArchivedData(noteText[i])
            let note = Note(sequence: i, prompt: notePrompt[i], encodedText: data, owner: currentAnxietyJournal)
            currentAnxietyJournal.notes.append(note)
        }

        // save the note to today's journal anxiety if it still the same day
        let currentDate = Date()
        let calendar = Calendar.current
        
        if calendar.isDate(fetchedTodayJournal.date, inSameDayAs: currentDate){
            fetchedTodayJournal.anxietyJournal.append(currentAnxietyJournal)
        }
        
       
    }
    
    //MARK: - this function handle relaxation phase in anxiety journaling
    func startRelaxationPhase(completion: @escaping () -> Void) {
        transitionToState(.breathIn, after: 0)
        transitionToState(.hold, after: 4)
        transitionToState(.breathOut, after: 11)
        transitionToState(.hold, after: 19)
        transitionToState(.initial, after: 23, completion: completion)
    }
    
    private func transitionToState(_ state: RelaxationState, after delay: TimeInterval, completion: (() -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation {
                self.relaxationState = state
            }
            completion?()
        }
    }
}

// MARK: - All of the class below are phases in relaxation section

class RelaxingPhase: ObservableObject {
    @Published var imageName: ImageResource
    @Published var title: String
    @Published var caption: String
    @Published var buttonLblText: String
    @Published var buttonIcon: String?
    
    init(imageName: ImageResource, title: String, caption: String, buttonLblText: String, buttonIcon: String?) {
        self.imageName = imageName
        self.title = title
        self.caption = caption
        self.buttonLblText = buttonLblText
        self.buttonIcon = buttonIcon
    }
}

enum RelaxationState {
    case initial
    case breathIn
    case hold
    case breathOut
    
    var state: RelaxingPhase {
        switch self {
        case .initial:
            return RelaxingPhase(
                imageName: .breath,
                title: String(localized: "Let’s calm down and take a relaxing breath"),
                caption: String(localized: "Inhale slowly, letting your lungs fill and your chest expand gently"),
                buttonLblText: String(localized: "Take Breath"),
                buttonIcon: "wind"
            )
        case .breathIn:
            return RelaxingPhase(
                imageName: .breathIn,
                title: String(localized: "Breath In"),
                caption: String(localized: "Inhale slowly, letting your lungs fill and your chest expand gently"),
                buttonLblText: String(localized: "Finish Earlier"),
                buttonIcon: nil
            )
        case .hold:
            return RelaxingPhase(
                imageName: .breath,
                title: String(localized: "Hold"),
                caption: String(localized: "Hold your breath for a moment, feeling the calm spread through your body"),
                buttonLblText: String(localized: "Finish Earlier"),
                buttonIcon: nil
            )
        case .breathOut:
            return RelaxingPhase(
                imageName: .breathOut,
                title: String(localized: "Breath Out"),
                caption: String(localized: "Exhale slowly, letting the air leave your lungs and your body relax"),
                buttonLblText: String(localized: "Finish Earlier"),
                buttonIcon: nil
            )
        }
    }
}
