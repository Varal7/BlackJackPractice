//
//  HintPopupView.swift
//  BlackJackPractice
//
//  Created by Victor Quach on 3/23/23.
//

import SwiftUI

struct HintPopupView: View {
    let hintText: String
    let onClose: () -> Void

    var body: some View {
        ZStack {
            // Full-screen translucent background
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    onClose()
                }

            // Hint content
            VStack(spacing: 16) {
                Text("Hint")
                    .font(.system(size: 24, weight: .bold))

                Text(hintText)
                    .font(.system(size: 18, weight: .medium))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)

                Button(action: onClose) {
                    Text("Close")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .frame(width: 400)
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .shadow(radius: 10)
        }
    }
}
