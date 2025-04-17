//
//  DailyJournalRowView.swift
//  NanoChallenge3
//
//  Created by Muhammad Rasyad Caesarardhi on 17/07/24.
//

import SwiftUI

struct DailyJournalRowView: View {
    var img: String
    var title: String
    var navigateAction: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "\(img)")
                .foregroundColor(Color.assetButton)
                .frame(width: 50, height: 60)
                .font(.system(size: 20))
                .fontWeight(.regular)
            HStack {
                Text("\(title)")
                    .font(.system(size: 17))
                Spacer()

                Button(
                    action: navigateAction,
                    label: {
                        Image(systemName: "chevron.right").foregroundColor(Color.assetButton)
                            .padding(.trailing, 16)
                            .fontWeight(.semibold)
                            .font(.system(size: 15))
                    })
            }
            .frame(width: 311, height: 60)
        }
        .background(.calendarBackground)
    }
}

#Preview {
    DailyJournalRowView(img: "list.bullet.clipboard", title: "Preparation of the Day") {}
}
