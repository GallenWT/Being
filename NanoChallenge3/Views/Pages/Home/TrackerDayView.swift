//
//  TrackerDayView.swift
//  NanoChallenge3
//
//  Created by Arrick Russell Adinoto on 15/07/24.
//

import SwiftUI

struct TrackerDayView: View {
    var day: String
    var emoji: ImageResource
    var date: String
    var body: some View {
        VStack {
            Text(day)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.gray)
                .frame(width: 44, height: 40)

            Image(emoji)
                .resizable()
                .frame(width: 36, height: 36)

            Text(date)
                .font(.system(size: 12, weight: .regular))
                .frame(width: 44, height: 40)
        }
        .frame(width: 44, height: 120)
    }
}

#Preview {
    TrackerDayView(day: "S", emoji: .emoHappy, date: "02")
}
