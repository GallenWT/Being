//
//  HomeView.swift
//  NanoChallenge3
//
//  Created by Arrick Russell Adinoto on 15/07/24.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var modelContext
    @State var isAlreadyWriting: Bool = false
    @StateObject var viewModel = JournalViewModel()

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                ForEach(0..<3) { _ in
                    Spacer()
                }

                HStack {
                    Text("Good Morning")
                        .fontWeight(.bold)
                        .font(.system(size: 34))
                    Spacer()
                }
                .frame(width: 361)

                Spacer()

                DailyJournalView(isAlreadyWriting: viewModel.isAlreadyWriting, todayJournalCheck: viewModel.todayJournalCheck)

                Spacer()

                VStack(alignment: .leading) {
                    HStack {
                        Text("Anxiety Tracker")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                        // .padding(.leading,10)
                        Spacer()

                        Image(systemName: "chevron.right").foregroundColor(Color.assetButton)
                            .padding(.trailing, 16)
                            .fontWeight(.semibold)
                            .font(.system(size: 15)).onTapGesture {
                                Router.shared.path.append(.Calendar)
                            }
                    }
                }
                .frame(width: 361)

                Spacer()

                TrackerWeekView(weeklyAnxietyLogDate: viewModel.weeklyAnxietyLogDate, weeklyAnxietyLogStatus: viewModel.weeklyAnxietyLogStatus)

                ForEach(0..<9) { _ in
                    Spacer()
                }

                BeingButton(buttonIconName: "pencil.line", buttonText: "Start Journaling") {
//                    isAlreadyWriting.toggle()
                    Router.shared.path.append(.StartJournaling)
                }
                .padding(.bottom, 32)

                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationTitle("Today's Journal")
        .toolbar(.hidden)
        .onAppear {
            viewModel.modelContext = modelContext
            viewModel.putAllJournal()
            viewModel.putTodayJournal()
            viewModel.putTodayJournal()
            viewModel.putTodayCheck()
            viewModel.loadWeeklyLogs()
            print(viewModel.todayJournal)
            
            Debugger.checkTodayJournalAtHome(viewModel, check: .anxiousJournal)
            
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        HomeView()
            .environment(\.colorScheme, .dark)
    }
}
