//
//  BeingButton.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 14/07/24.
//

import SwiftUI

struct BeingButton: View {
    var buttonIconName: String?
    var buttonText: String
    var buttonRole: BeingButtonRole = .proceed
    var buttonAction: () -> Void
    
    
    var body: some View {
        Button(
            action: buttonAction,
            label: {
                if let buttonIconName = buttonIconName {
                    Image(systemName: buttonIconName)
                        .tint(.assetButtonFill)
                }
                Text(buttonText).foregroundStyle(.assetButtonFill).font(Font.system(size: 17))

            }).padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(.assetButton)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 4)
    }
}

#Preview {
    BeingButton(buttonIconName: "globe", buttonText: "Test") {
        print("Test button")
    }
}
