//
//  PromptWithButtonView.swift
//  NanoChallenge3
//
//  Created by Muhammad Rasyad Caesarardhi on 14/07/24.
//

import SwiftUI

struct PromptWithButtonView: View {
    var imageName: ImageResource
    var headerText: String
    var detailText: String
    var buttonLabelText: String
    var buttonIconName: String?
    var buttonRole: BeingButtonRole = .proceed
    var buttonAction: () -> Void

    var body: some View {
        ZStack {

            VStack(spacing: 56) {
                LogoWithTextView(imageName: imageName, headerText: headerText, detailText: detailText)

                BeingButton(buttonIconName: buttonIconName, buttonText: buttonLabelText, buttonRole: buttonRole, buttonAction: buttonAction)
            }
        }
    }
}

#Preview {
    PromptWithButtonView(imageName: .beingWrite, headerText: "Let’s calm down and take a relaxing breath", detailText: "Inhale slowly, letting your lungs fill and your chest expand gently", buttonLabelText: "Button", buttonIconName: "wind") {
        print("Test Button")
    }
}
