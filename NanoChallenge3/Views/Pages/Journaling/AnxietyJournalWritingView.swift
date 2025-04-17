//
//  AnxietyJournalWritingView.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 14/07/24.
//

import SwiftUI
import SwiftData

struct AnxietyJournalWritingView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = AnxietyJournalingViewModelManager()
    
    @Environment(\.dismiss) private var dismiss
    @State private var whiteBackground: Bool = false
    @State private var currentTab: Int = 0
    
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
                    imageName: .beingWrite,
                    headerText: String(localized: "Take a moment for yourself and start journaling!"),
                    detailText: String(localized: "Feeling anxious? It’s okay. Breath, relax, and trust that you will be okay.")
                )
                .onChange(of: currentTab) { _, _ in
                    if currentTab == 0 {
                        withAnimation {
                            whiteBackground = false
                        }
                    }
                }
                .tag(0)
                .transition(.slide)
                
                PromptWithButtonView(
                    imageName: viewModel.relaxationState.state.imageName,
                    headerText: viewModel.relaxationState.state.title,
                    detailText: viewModel.relaxationState.state.caption,
                    buttonLabelText: viewModel.relaxationState.state.buttonLblText,
                    buttonIconName: viewModel.relaxationState.state.buttonIcon
                ) {
                    // this will run to skip to the next slide
                    if viewModel.nextButtonEnabled == false {
                        goToTheNextPage()
                        viewModel.relaxationState = .initial
                        viewModel.nextButtonEnabled = true
                    } else {
                        viewModel.nextButtonEnabled = false
                        viewModel.startRelaxationPhase {
                            goToTheNextPage()
                            viewModel.nextButtonEnabled = true
                        }
                    }
                }
                .onChange(of: currentTab) { _, _ in
                    if currentTab == 1 {
                        withAnimation {
                            whiteBackground = false
                        }
                    }
                }
                .tag(1)
                .transition(.slide)
                
                PromptView(
                    imageName: .beingWrite,
                    headerText: String(localized: "Writing down worries calms and focuses the mind"),
                    detailText: String(localized: "Storing your thoughts here can help you focus on your task because you know you can revisit them.")
                )
                .onChange(of: currentTab) { _, _ in
                    if currentTab == 2 {
                        withAnimation {
                            whiteBackground = false
                        }
                    }
                }
                .tag(2)
                .transition(.slide)
                .onAppear(){
                    hideKeyboard()
                }
                
                WritingJournalView(
                    journalPrompt: viewModel.notePrompt[0],
                    text: $viewModel.noteText[0]
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
                    journalPrompt: viewModel.notePrompt[1],
                    text: $viewModel.noteText[1]
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
                
                WritingJournalView(
                    journalPrompt: viewModel.notePrompt[2],
                    text: $viewModel.noteText[2]
                )
                .onChange(of: currentTab) { _, _ in
                    if currentTab == 5 {
                        withAnimation {
                            whiteBackground = true
                        }
                    }
                }
                .tag(5)
                .transition(.slide)
                
                WritingJournalView(
                    journalPrompt: viewModel.notePrompt[3],
                    text: $viewModel.noteText[3]
                )
                .onChange(of: currentTab) { _, _ in
                    if currentTab == 6 {
                        withAnimation {
                            whiteBackground = true
                        }
                    }
                }
                .tag(6)
                .transition(.slide)
                
                PromptView(
                    imageName: .beingAfterJournal,
                    headerText: String(localized: "A calm mind brings happiness"),
                    detailText: String(localized: "Congratulate yourself because it takes courages to write on your thoughts")
                )
                .onChange(of: currentTab) { _, _ in
                    if currentTab == 7 {
                        withAnimation {
                            whiteBackground = false
                        }
                    }
                }
                .onAppear(){
                    hideKeyboard()
                }
                .tag(7)
                .transition(.slide)
            }
            .animation(.linear, value: currentTab)
            .onAppear {
                UIScrollView.appearance().isScrollEnabled = false
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            if viewModel.nextButtonEnabled {
                NextButton {
                    goToTheNextPage()
                }
                .padding(.horizontal, 32)
                .padding(.bottom, whiteBackground ? 72 : 32)
            }
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
                    .tint(whiteBackground ? Color.assetButton : Color.primary)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    Router.shared.path.removeLast()
                }, label: {
                    Image(systemName: "xmark")
                })
                .tint(whiteBackground ? Color.assetButton : Color.primary)
            }
        }
        .navigationBarTitle(displayTitleForCurrentTab(), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            viewModel.modelContext = modelContext
        }
    }
    
    // MARK: - This function only handles the UI changes, because of that, this is not necessary to move this function to the view model

    func goToTheNextPage() {
        if currentTab <= 7 {
            currentTab += 1
        }
        if currentTab == 8 {
            // Go To Home View
            viewModel.finishWritingSection()
            Router.shared.path.removeAll()
        }
    }
    
    func displayTitleForCurrentTab() -> String {
        switch currentTab {
        case 3:
            return "1 of 4"
        case 4:
            return "2 of 4"
        case 5:
            return "3 of 4"
        case 6:
            return "4 of 4"
        default:
            return ""
        }
    }
}

#Preview("English") {
    NavigationStack {
        AnxietyJournalWritingView()
    }
}
