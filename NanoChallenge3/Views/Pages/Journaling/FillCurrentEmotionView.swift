//
//  FillCurrentEmotionView.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 15/07/24.
//

import SwiftUI

struct FillCurrentEmotionView: View {
    @Binding var selection: Emotion
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(.beingQuestion)
                .resizable()
                .frame(width: 306, height: 207)
            Text(String(localized: "How you’ve felt overall today?"))
                .font(.title3)
                .fontWeight(.bold)
            
            List {
                currentEmotionRow(
                    image: .emoHappy,
                    caption: String(localized: "Today went well"),
                    checked: selection == Emotion.happy
                )
                .onTapGesture {
                    selection = Emotion.happy
                }
                currentEmotionRow(
                    image: .emoAnxiety,
                    caption: String(localized: "Feel anxious today"),
                    checked: selection == Emotion.anxiety
                )
                .onTapGesture {
                    selection = Emotion.anxiety
                }
            }
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            .frame(height: 200)
            .padding(.vertical, -30)
            
            Text(String(localized: "Keeping a log of your anxious feelings can help you understand how to overcome your anxiety and track your progress."))
                .font(.subheadline)
                .foregroundStyle(Color.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
    }
}

struct currentEmotionRow: View {
    var image: ImageResource
    var caption: String
    var checked: Bool
    
    var body: some View {
        HStack {
           Image(image)
                .resizable()
                .frame(width: 40, height: 40)
            Text(caption)
                .padding(.horizontal, 10)
            
            Spacer()
            if checked {
                Image(systemName: "checkmark")
                    .foregroundStyle(.assetButton)
            }
        }
    }
}

#Preview {
    FillCurrentEmotionView(selection: .constant(Emotion.happy))
}
