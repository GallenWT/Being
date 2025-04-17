//
//  NanoChallenge3App.swift
//  NanoChallenge3
//
//  Created by Arrick Russell Adinoto on 08/07/24.
//

import SwiftData
import SwiftUI

@main
@MainActor
struct NanoChallenge3App: App {
    // Initialize the shared model container using the ModelContainerManager
    var sharedModelContainer: ModelContainer = ModelContainerProvider.createModelContainer()

    var body: some Scene {
        WindowGroup {
//            NavigationStack {
//                AnxietyTrackerView()
//            }
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
