//
//  ModelContainer.swift
//  NanoChallenge3
//
//  Created by Muhammad Rasyad Caesarardhi on 14/07/24.
//

import SwiftData
import SwiftUI

class ModelContainerProvider {
    static func createModelContainer() -> ModelContainer {
        let schema = setModelContainerSchema()
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            let container = try ModelContainer(for: schema, configurations: modelConfiguration)
            Task { @MainActor in
                TodayJournal.reloadSampleData(modelContext: container.mainContext)
            }
            return container
        } catch {
            fatalError("Could not create the Model Container: \(error)")
        }
    }
    
    private static func setModelContainerSchema() -> Schema {
        return Schema([
            TodayJournal.self
        ])
    }
}
