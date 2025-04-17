//
//  FSCalendarView.swift
//  Calendar
//
//  Created by Muhammad Rasyad Caesarardhi on 14/07/24.
//

import FSCalendar
import SwiftData
import SwiftUI

struct FSCalendarView: UIViewRepresentable {
    @Binding var selectedDate: Date
    @Binding var notesCollection: [TodayJournal]
    var modelContext: ModelContext?
        
    func makeCoordinator() -> Coordinator {
        Coordinator(self, notesCollection: notesCollection)
    }
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        calendar.appearance.weekdayTextColor = .primaryColorGray
        calendar.appearance.selectionColor = .calendarDateBackground
        calendar.appearance.titleSelectionColor = .calendarDateTitle
        calendar.appearance.headerTitleColor = .calendarMonthYear
        
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        calendar.today = nil
        
        // Remove today circle
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        context.coordinator.notesCollection = notesCollection
        context.coordinator.parent = self
        
        let descriptor = FetchDescriptor<TodayJournal>()
        var notess = (try? modelContext?.fetch(descriptor)) ?? []

        print("======notescollection=======")
        print(notess)
        print("======notescollection=======")
        
        for note in notess {
            print(note)
            context.coordinator.dateWithEmotion.updateValue(note.status!, forKey: note.date)
        }
        
        print("dict emotion")
        print(context.coordinator.dateWithEmotion)
        
        uiView.reloadData()
    }
    
    // MARK: - Coordinator

    class Coordinator: NSObject, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
        var parent: FSCalendarView
        
        var notesCollection: [TodayJournal] {
            didSet {
                for note in notesCollection {
                    print(note)
                    dateWithEmotion.updateValue(note.status!, forKey: note.date)
                }
            }
        }
        
        var dateWithEmotion: [Date: Emotion] = [:] {
            didSet {
                for note in notesCollection {
                    print(note)
                    dateWithEmotion.updateValue(note.status!, forKey: note.date)
                }
            }
        }
        
        var modelContext: ModelContext?
        
        init(_ calender: FSCalendarView, notesCollection: [TodayJournal]) {
            self.parent = calender
            self.notesCollection = notesCollection
//            print("======notescollection=======")
//            print(notesCollection)
//            print("======notescollection=======")
//            // notesCollection kan bukan array jd gak bisa difilter(?)
//            print("ini init")
            
//            let descriptor = FetchDescriptor<TodayJournal>()
//
//            var notess = (try? modelContext?.fetch(descriptor)) ?? []
//
//            print("======notescollection=======")
//            print(notess)
//            print("======notescollection=======")
//
//            for note in notess {
//                print(note)
//                dateWithEmotion.updateValue(note.status!, forKey: note.date)
//            }
//
//            print(dateWithEmotion)
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            calendar.reloadData() // Refresh the calendar to apply the changes
            parent.selectedDate = date
        }
        
        func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
            let targetSize = CGSize(width: 45, height: 45)
            let anxietyStatus: Emotion = dateWithEmotion[date] ?? .none
//            print("================func calendar===================")
//            print(dateWithEmotion)
//            print(date)
//            print(anxietyStatus)
//            print("================func calendar===================")
//
            if let stat = dateWithEmotion.first(where: { Calendar.current.isDate($0.key, inSameDayAs: date) })?.value {
                switch stat {
                case .happy:
                    let originalImage = UIImage(resource: .emoHappy)
                    return originalImage.resized(to: targetSize)
                case .anxiety:
                    let originalImage = UIImage(resource: .emoAnxiety)
                    return originalImage.resized(to: targetSize)
                case .none:
                    return nil
                }
            }
            
            if date == parent.selectedDate {
                return nil
            }
            // Calculate the date for yesterday
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            
            // Check if the date is before yesterday
            
            switch anxietyStatus {
            case .happy:
                let originalImage = UIImage(resource: .emoHappy)
                return originalImage.resized(to: targetSize)
            case .anxiety:
                let originalImage = UIImage(resource: .emoAnxiety)
                return originalImage.resized(to: targetSize)
            case .none:
                return nil
            }
            
            return nil
        }
        
        // Need reload to have fill colors display correctly after calendar page changes
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            print("ini berubah")
            calendar.reloadData()
        }
        
        // MARK: - Other

        func isDateInMonth(date: Date, targetMonth: Date) -> Bool {
            return Calendar.current.isDate(date, equalTo: targetMonth, toGranularity: .month)
        }
    }
}
