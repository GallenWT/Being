//
//  RouterView.swift
//  NanoChallenge3
//
//  Created by Muhammad Rasyad Caesarardhi on 10/07/24.
//

import SwiftData
import SwiftUI
import UIKit

struct RouterView: View {
    @StateObject private var navPath = Router.shared
    @Environment(\.modelContext) var modelContext
    @StateObject var viewModel = JournalViewModel()

    var body: some View {
        NavigationStack(path: $navPath.path) {
            // This is the root page view (you can use anything)
            // It does not have to be SplashScreenView
//            SplashScreenView()
            HomeView()

                // end of the root page view
                .toolbar(.hidden)
                .navigationDestination(for: Router.Destination.self) { destination in
                    switch destination {
                    case .AnxietyJournal:
                        AnxietyJournalWritingView()
                    case .StartJournaling:
                        TodayJournalView()
                    case .Calendar:
                        AnxietyTrackerView()
                    case .PreparationJournaling:
                        MorningJournalWritingView()
                    case .Home:
                        HomeView()
                    case .ReflectionJournaling:
                        EveningJournalWritingView()
                    }
                }
        }.onAppear {
            viewModel.modelContext = modelContext
            viewModel.putTodayJournal()
        }
    }
}

// #Preview {
//    ModelContainerPreview(modelContainer: ModelContainer.sample) {
//        RouterView()
//    }
// }
