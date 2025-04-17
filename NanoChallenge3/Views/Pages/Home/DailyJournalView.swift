//
//  DailyJournalView.swift
//  NanoChallenge3
//
//  Created by Arrick Russell Adinoto on 15/07/24.
//

import SwiftData
import SwiftUI

struct DailyJournalView: View {
    var isAlreadyWriting: Bool
    
    var todayJournalCheck: [Bool]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Today's Journal")
                .fontWeight(.semibold)
                .font(.system(size: 20))
            
            if isAlreadyWriting {
                VStack(alignment: .trailing, spacing: 0) {
                    // Preparation of the Day
                    if todayJournalCheck[0] {
                        DailyJournalRowView(img: "list.bullet.clipboard", title: "Preparation of the Day") {}
                    }
                    
                    // Divider
                    HStack {
                        Spacer()
                        VStack {
                            Divider()
                                .background(Color.primaryColorGray)
                        }
                        .frame(width: 311)
                    }
                    .background(.calendarBackground)
                    
                    // Thought Dump Journal
                    if todayJournalCheck[1] {
                        DailyJournalRowView(img: "pencil.and.scribble", title: "Thought Dump Journal") {}
                    }
                    
                    // Divider
                    HStack {
                        Spacer()
                        VStack {
                            Divider()
                                .background(Color.primaryColorGray)
                        }
                        .frame(width: 311)
                    }
                    .background(.calendarBackground)
                    
                    // End of the Day Reflection
                    if todayJournalCheck[2] {
                        DailyJournalRowView(img: "bubbles.and.sparkles.fill", title: "End of the Day Reflection") {}
                    }
                }
                .frame(width: 361)
                .background(Color.assetButtonFill)
                .cornerRadius(10)
            }
            else {
                VStack {
                    Spacer()
                    Text(String(localized: "Ready to Begin Your Journaling"))
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(Color.primaryColorGray)
                    Text(String(localized: "Journey with Being?"))
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(Color.primaryColorGray)
                    Text(String(localized: "Let's start writing!"))
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(Color.primaryColorGray)
                    Spacer()
                    Spacer()
                }
                .frame(width: 361, height: 120)
            }
        }
    }
}

#Preview {
    DailyJournalView(isAlreadyWriting: true, todayJournalCheck: [false, false, true])
}
