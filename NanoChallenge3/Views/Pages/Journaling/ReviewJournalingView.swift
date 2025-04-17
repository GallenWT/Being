//
//  ReviewJournalingView.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 15/07/24.
//

import RichTextKit
import SwiftUI

struct ReviewJournalingView: View {
    var journaling: JournalContainer

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                ForEach(journaling.notes.indices, id: \.self) { index in
                    ReviewRow(
                        data: journaling.notes[index]
                    )
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

struct ReviewRow: View {
    var data: Note

    var body: some View {
        if let content = convertDataToAttributedString(data) {
            VStack(alignment: .leading, spacing: 12) {
                Text(String(localized: "\(data.prompt)"))
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(content.string)
                    .font(.body)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
