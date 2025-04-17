//
//  BackgroundView.swift
//  Open
//
//  Created by Arrick Russell Adinoto on 16/07/24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(colors:[Color.backgroundGradientStart,Color.backgroundGradientStop],startPoint:.top,endPoint:.bottom)    }
}

#Preview {
    BackgroundView()
}
