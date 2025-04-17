//
//  PromptView.swift
//  NanoChallenge3
//
//  Created by Muhammad Rasyad Caesarardhi on 14/07/24.
//

import SwiftUI

struct PromptView: View {
    var imageName: ImageResource
    var headerText: String
    var detailText: String

    var body: some View {
        ZStack {
            LogoWithTextView(imageName: imageName, headerText: headerText, detailText: detailText)
        }
    }
}

#Preview {
    PromptView(imageName: .beingAfterJournal, headerText: "Let’s calm down and take a relaxing breath", detailText: "Inhale slowly, letting your lungs fill and your chest expand gently")
}
