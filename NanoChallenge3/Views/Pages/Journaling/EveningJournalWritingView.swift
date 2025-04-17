//
//  EveningJournalWritingView.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 15/07/24.
//

import SwiftUI

import SwiftUI

struct EveningJournalWritingView: View {
    let totalPage = 4
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var whiteBackground: Bool = false
    @State private var currentTab: Int = 0
    
    @StateObject private var viewmodel = EveningJournalWritingViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing, content: {
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
                    imageName: .beingEvening,
                    headerText: String(localized: "End the day with a journal reflection"),
                    detailText: String(localized: "Reflect on your day in your journal before ending the day to capture thoughts and emotions")
                )
                .onAppear {
                    withAnimation {
                        whiteBackground = false
                    }
                    hideKeyboard()
                }
                .tag(0)
                .transition(.slide)
                
                WritingJournalView(
                    journalPrompt: viewmodel.notePrompt[0],
                    text: $viewmodel.noteText[0]
                )
                .onAppear {
                    withAnimation {
                        whiteBackground = true
                    }
                }
                .tag(1)
                .transition(.slide)
                
                WritingJournalView(
                    journalPrompt: viewmodel.notePrompt[1],
                    text: $viewmodel.noteText[1]
                )
                .onAppear {
                    withAnimation {
                        whiteBackground = true
                    }
                }
                .tag(2)
                .transition(.slide)
                
                WritingJournalView(
                    journalPrompt: viewmodel.notePrompt[2],
                    text: $viewmodel.noteText[2]
                )
                .onAppear {
                    withAnimation {
                        whiteBackground = true
                    }
                }
                .tag(3)
                .transition(.slide)
                
                FillCurrentEmotionView(selection: $viewmodel.status)
                    .onAppear {
                        withAnimation {
                            whiteBackground = false
                        }
                        hideKeyboard()
                    }
                    .tag(4)
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
        })
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                if currentTab >= 1 {
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
                    // Handle close action
                    Router.shared.path.removeLast()
                }, label: {
                    Image(systemName: "xmark")
                })
                .tint(.primary)
            }
        }
        .navigationBarTitle(displayTitleForCurrentTab(), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            viewmodel.modelContext = modelContext
        }
    }
    
    // MARK: - This function only handles the UI changes, because of that, this is not necessary to move this function to the view model

    func goToTheNextPage() {
        if currentTab <= totalPage {
            currentTab += 1
        }
        if currentTab == totalPage + 1 {
            // Go To Home View
            viewmodel.finishWritingSection()
            Router.shared.path.removeAll()
        }
    }
    
    func displayTitleForCurrentTab() -> String {
        switch currentTab {
        case 1:
            return "1 of 3"
        case 2:
            return "2 of 3"
        case 3:
            return "3 of 3"
        default:
            return ""
        }
    }
}

#Preview {
    NavigationStack {
        EveningJournalWritingView()
    }
}
