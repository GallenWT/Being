//
//  ImageWithTextView.swift
//  NanoChallenge3
//
//  Created by Muhammad Rasyad Caesarardhi on 14/07/24.
//

import SwiftUI

struct LogoWithTextView: View {
    var imageName: ImageResource
    var headerText: String
    var detailText: String

    var body: some View {
        VStack(spacing: 24) {
            Image(imageName)
                .resizable()
                .frame(width: 306, height: 207)
            
            VStack(spacing: 8) {
                Text(headerText)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .foregroundColor(.labelPrimary)
                    .font(Font.system(size: 22))

                Text(detailText)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.labelPrimary)
                    .font(Font.system(size: 17))
            }
            .padding(.horizontal, 44)
           
        }
    }
}

#Preview {
    LogoWithTextView(imageName: .beingZen, headerText: "Let’s calm down and take a relaxing breath", detailText: "Inhale slowly, letting your lungs fill and your chest expand gently")
}
