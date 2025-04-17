//
//  HomeViewModel.swift
//  NanoChallenge3
//
//  Created by Muhammad Rasyad Caesarardhi on 17/07/24.
//

import Foundation
import SwiftData

class HomeViewModel: ObservableObject {
    var modelContext: ModelContext?
    @Published var todayJournals: [TodayJournal] = []
    var todayJournal: TodayJournal?

    func fetchJournals() {
        guard let modelContext = modelContext else {
            print("model context is not initialized")
            return
        }
        todayJournals.removeAll()
        let descriptor = FetchDescriptor<TodayJournal>()

        guard let fetchedJournals = try? modelContext.fetch(descriptor) else {
            print("failed to fetch")
            return
        }

        print("this is HOMEVIEWMODEL")
        print(fetchedJournals)
    }
}
