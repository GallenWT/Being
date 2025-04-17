//
//  CalendarView.swift
//  Calendar
//
//  Created by Muhammad Rasyad Caesarardhi on 14/07/24.
//

import SwiftData
import SwiftUI

struct CalendarView: View {
    @Environment(\.modelContext) var context
    @StateObject var journalViewModel: JournalViewModel = .init()
    @Binding var selectedDate: Date

    var body: some View {
        ZStack {
            Color.calendarBackground
            ScrollView {
                VStack {
                    FSCalendarView(selectedDate: $selectedDate, notesCollection: $journalViewModel.todayJournalList, modelContext: context)
                        .frame(height: 350)
                }
            }
        }.onAppear {
            journalViewModel.modelContext = context
            journalViewModel.putAllJournal()
        }
        .cornerRadius(13).padding(.horizontal, 20)
    }

    func formatDateToUTC7(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 7 * 3600)
        return formatter.string(from: date)
    }
}
