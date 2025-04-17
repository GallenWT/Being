//
//  TrackerWeekView.swift
//  NanoChallenge3
//
//  Created by Arrick Russell Adinoto on 15/07/24.
//

import SwiftData
import SwiftUI

struct TrackerWeekView: View {
    var day: [String] = ["S", "M", "T", "W", "T", "F", "S"]
    var emoji: [String] = ["EmoAnxiety", "EmoHappy", "EmoFreeze", "EmoAnxiety", "EmoAnxiety", "EmoHappy", "EmoBlank"]
    var date: [Int] = [7, 8, 9, 10, 11, 12, 13]

    var weeklyAnxietyLogDate: [Date]
    var weeklyAnxietyLogStatus: [ImageResource]

    var body: some View {
        HStack {
            ForEach(0 ..< 7, id: \.self) { index in
                TrackerDayView(
                    day: getDayOfWeek(from: weeklyAnxietyLogDate[index]),
                    emoji: weeklyAnxietyLogStatus[index],
                    date: getDateOnly(from: weeklyAnxietyLogDate[index]))
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 120)
    }
}

// #Preview {
//    TrackerWeekView()
// }
