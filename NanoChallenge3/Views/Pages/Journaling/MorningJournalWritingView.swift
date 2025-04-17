//
//  MorningJournalWritingView.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 15/07/24.
//

import SwiftUI

struct MorningJournalWritingView: View {
    let totalPage = 5
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var whiteBackground: Bool = false
    @State private var currentTab: Int = 0
    
    @StateObject private var viewmodel = MorningJournalingManagerViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if whiteBackground {
                Color.backgroundGradientStop
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.linear, value: whiteBackground)
            } else {
                BackgroundView()
                    .transition(.opacity)
                    .animation(.linear, value: whiteBackground)
            }
            
            TabView(selection: $currentTab) {
                PromptView(
                    imageName: .beingMorning,
                    headerText: String(localized: "Prepare your wonderful day with journaling"),
                    detailText: String(localized: "Leave all your thoughts here and focus on your day")
                )
                .onChange(of: currentTab) { _, _ in
                    if currentTab == 0 {
                        withAnimation {
                            whiteBackground = false
                        }
                    }
                }
                .onAppear(){
                    hideKeyboard()
                }
                .tag(0)
                .transition(.slide)
                
                WritingJournalView(
                    journalPrompt: viewmodel.notePrompt[0],
                    text: $viewmodel.noteText[0]
                )
                .onChange(of: currentTab) { _, _ in
                    if currentTab == 1 {
                        withAnimation {
                            whiteBackground = true
                        }
                    }
                }
                .tag(1)
                .transition(.slide)
                
                WritingJournalView(
                    journalPrompt: viewmodel.notePrompt[1],
                    text: $viewmodel.noteText[1]
                )
                .onChange(of: currentTab) { _, _ in
                    if currentTab == 2 {
                        withAnimation {
                            whiteBackground = true
                        }
                    }
                }
                .tag(2)
                .transition(.slide)
                
                WritingJournalView(
                    journalPrompt: viewmodel.notePrompt[2],
                    text: $viewmodel.noteText[2]
                )
                .onChange(of: currentTab) { _, _ in
                    if currentTab == 3 {
                        withAnimation {
                            whiteBackground = true
                        }
                    }
                }
                .tag(3)
                .transition(.slide)
                
                WritingJournalView(
                    journalPrompt: viewmodel.notePrompt[3],
                    text: $viewmodel.noteText[3]
                )
                .onChange(of: currentTab) { _, _ in
                    if currentTab == 4 {
                        withAnimation {
                            whiteBackground = true
                        }
                    }
                }
                .tag(4)
                .transition(.slide)
                
                PromptView(
                    imageName: .beingGoodJob,
                    headerText: String(localized: "Prepared for a peaceful day ahead"),
                    detailText: String(localized: "Set and focused for a serene and productive day ahead")
                )
                .onChange(of: currentTab) { _, _ in
                    if currentTab == 5 {
                        withAnimation {
                            whiteBackground = false
                        }
                    }
                }
                .onAppear(){
                    hideKeyboard()
                }
                .tag(5)
                .transition(.slide)
            }
            .animation(.linear, value: currentTab)
            .onAppear {
                UIScrollView.appearance().isScrollEnabled = false
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            NextButton {
                goToTheNextPage()
            }
            .padding(.horizontal, 32)
            .padding(.bottom, whiteBackground ? 72 : 32)
        }
        .toolbar {
            if currentTab >= 1 {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        if currentTab > 0 {
                            currentTab -= 1
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                    })
                    .tint(.primary)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    // TODO: dismiss the view
                    Router.shared.path.removeLast()
                }, label: {
                    Image(systemName: "xmark")
                })
                .tint(.primary)
            }
        }
        .onAppear(){
            viewmodel.modelContext = modelContext
        }
        .navigationBarTitle(displayTitleForCurrentTab(), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - This function only handles the UI changes, because of that, this is not necessary to move this function to the view model

    func goToTheNextPage() {
        if currentTab <= totalPage {
            currentTab += 1
        }
        if currentTab == totalPage + 1 {
            viewmodel.finishWritingSection()
            Router.shared.path.removeAll()
        }
    }
    
    func displayTitleForCurrentTab() -> String {
        switch currentTab {
        case 1:
            return "1 of 4"
        case 2:
            return "2 of 4"
        case 3:
            return "3 of 4"
        case 4:
            return "4 of 4"
        default:
            return ""
        }
    }
}

#Preview {
    NavigationStack {
        MorningJournalWritingView()
    }
}
