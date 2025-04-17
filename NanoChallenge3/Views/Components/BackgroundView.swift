//
//  BackgroundView.swift
//  NanoChallenge3
//
//  Created by Muhammad Rasyad Caesarardhi on 14/07/24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.backgroundGradientStart, .backgroundGradientStop]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
