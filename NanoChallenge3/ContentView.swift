//
//  ContentView.swift
//  NanoChallenge3
//
//  Created by Arrick Russell Adinoto on 08/07/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var context

    var body: some View {
        RouterView()
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        ContentView()
    }
}
