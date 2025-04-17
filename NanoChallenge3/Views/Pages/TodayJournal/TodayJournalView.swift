//
//  TodayJournalView.swift
//  NanoChallenge3
//
//  Created by Arrick Russell Adinoto on 15/07/24.
//

import SwiftUI

struct TodayJournalView: View {
    var img: [String]=["kategoriThought", "KategoriPrep", "KategoriReflect"]

    var title: [String]=[
        String(localized: "Thought Dump Journal"),
        String(localized: "Preparation of The Day"),
        String(localized: "End of the Day Reflection")
    ]

    var desc: [String]=[
        String(localized: "Your thoughts deserve a safe space"),
        String(localized: "Preparation of The Day"),
        String(localized: "Think, Learned, and Do Better Tomorrow")
    ]

    var routing: [Router.Destination]=[
        .AnxietyJournal,
        .PreparationJournaling,
        .ReflectionJournaling
    ]

    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 15) {
                ForEach(0 ..< 3, id: \.self) { index in
                    TodayJournalCardView(img: img[index], title: title[index], desc: desc[index]).onTapGesture {
                        Router.shared.path.append(routing[index])
                    }
                }
            }
            .padding([.leading, .trailing], 20)
        }
        .navigationBarBackButtonHidden(false).tint(.black)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    NavigationStack {
        TodayJournalView().environment(\.locale, Locale(identifier: "id"))            .environment(\.colorScheme, .dark)

    }
}
