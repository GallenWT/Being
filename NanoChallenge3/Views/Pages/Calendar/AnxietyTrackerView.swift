//
//  AnxietyTrackerView.swift
//  NanoChallenge3
//
//  Created by Muhammad Rasyad Caesarardhi on 15/07/24.
//

import SwiftData
import SwiftUI

struct AnxietyTrackerView: View {
    @Environment(\.modelContext) var context

    @State private var selectedDate: Date = .init()
    @StateObject var viewModel: JournalViewModel = .init()

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                ZStack {
                    Color.calendarBackground
                    CalendarView(selectedDate: $selectedDate)
                        .padding()
                }
                .cornerRadius(13).padding(.horizontal, 20).frame(height: 400)

                HStack(spacing: 0) {
                    Text(getDayOfWeek(from: selectedDate)).foregroundStyle(.labelPrimary).font(
                        .system(size: 20)
                            .weight(.semibold)
                    )
                    Text(", ").foregroundStyle(.labelGray).opacity(0.5).font(
                        .system(size: 20)
                            .weight(.semibold))
                    Text(formatDateToDateMonth(selectedDate)).foregroundStyle(.labelGray).opacity(0.5).font(
                        .system(size: 20)
                            .weight(.semibold))
                }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 20).padding(.top, 15)
                Divider().padding(.horizontal, 20)

                if viewModel.selectedDateJournal != nil && viewModel.selectedDateJournal?.morningJournal != nil &&
                    viewModel.selectedDateJournal?.anxietyJournal.count != 0 &&
                    viewModel.selectedDateJournal?.eveningJournal != nil
                {
                    VStack(alignment: .trailing, spacing: 0) {
                        // Preparation of the Day
                        if viewModel.selectedDateJournal?.morningJournal != nil {
                            DailyJournalRowView(img: "list.bullet.clipboard", title: "Preparation of the Day") {
//                                TODO: ACTION ROUTING DI SINI
                            }
                        }

                        // Divider
                        if viewModel.selectedDateJournal?.morningJournal != nil && viewModel.selectedDateJournal?.anxietyJournal.count != 0 {
                            HStack {
                                Spacer()
                                VStack {
                                    Divider()
                                        .background(Color.primaryColorGray)
                                }
                                .frame(width: 311)
                            }
                        }

                        if viewModel.selectedDateJournal?.anxietyJournal.count != 0 {
                            // Thought Dump Journal
                            DailyJournalRowView(img: "pencil.and.scribble", title: "Thought Dump Journal") {
                                // TODO: ACTION ROUTING DI SINI
                            }
                        }

                        // Divider

                        if viewModel.selectedDateJournal?.anxietyJournal.count != 0 && viewModel.selectedDateJournal?.eveningJournal != nil {
                            HStack {
                                Spacer()
                                VStack {
                                    Divider()
                                        .background(Color.primaryColorGray)
                                }
                                .frame(width: 311)
                            }
                        }

                        if viewModel.selectedDateJournal?.eveningJournal != nil {
                            // Thought Dump Journal
                            DailyJournalRowView(img: "bubbles.and.sparkles.fill", title: "End of the Day Reflection") {
//                                TODO: action routing di sini
                            }
                        }
                    }
                    .frame(width: 361, height: 120)
                    .background(Color.assetButtonFill)
                    .cornerRadius(10)
                }

                Spacer()
            }
        }.navigationTitle("AnxietyTracker").navigationBarBackButtonHidden(false).onAppear {
            viewModel.modelContext = context
            viewModel.putSelectedDateJournal(date: selectedDate)
        }.onChange(of: selectedDate) {
            viewModel.putSelectedDateJournal(date: selectedDate)
        }
    }
}

func getDayOfWeek(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    return formatter.string(from: date)
}

func getSingleTextDayOfWeek(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "ee"

    return String(formatter.string(from: date).prefix(1))
}

func getDateOnly(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    return formatter.string(from: date)
}

func formatDateToDateMonth(_ date: Date, format: String = "dd MMMM") -> String {
    if date == Date() { return "Today" }
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
}

func formatDateToUTC7(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.timeZone = TimeZone(secondsFromGMT: 7 * 3600)
    return formatter.string(from: date)
}

// #Preview {
////    ModelContainerPreview(ModelContainer.sample) {
////        AnxietyTrackerView()
////    }
// }
