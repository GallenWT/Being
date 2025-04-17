/*
 See the LICENSE.txt file for this sample’s licensing information.

 Abstract:
 An extension that creates a sample model container to use when previewing
  views in Xcode.
 */

import SwiftData

extension ModelContainer {
    // TODO: Kasi penjelasan buat apa
    // sample container ini digunakan agar preview bisa jalan tanpa perlu dirun simulator lagi
    static var sample: () throws -> ModelContainer = {
        let schema = Schema([
            TodayJournal.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        Task { @MainActor in
            TodayJournal.reloadSampleData(modelContext: container.mainContext)
        }
        return container
    }
}
