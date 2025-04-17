//
//  NextButton.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 14/07/24.
//

import SwiftUI

struct NextButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .tint(.assetButton)
                    .frame(width: 45, height: 45, alignment: .center)
                    .cornerRadius(22.5)
                Image(systemName: "chevron.right")
                    .tint(.assetButtonFill)
            }
            
        }
    }
}

#Preview {
    NextButton(action: {
        print("Test button")
    })
}
