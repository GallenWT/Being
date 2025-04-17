//
//  AccesoryCircularView.swift
//  MainWidgetExtension
//
//  Created by Muhammad Rasyad Caesarardhi on 16/07/24.
//

import SwiftUI
import WidgetKit

struct AccesoryCircularView: View {
    var body: some View {
        ZStack {
            Color.d0D0D0.opacity(0.4)
            Image("AccesoryCircularLogo").foregroundColor(.white)
        }
        .cornerRadius(180)
        .widgetURL(URL(string: "OpenApp://ProfileView")!).containerBackground(.background, for: .widget)
    }
}

#Preview {
    AccesoryCircularView()
}
