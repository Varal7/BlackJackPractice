//
//  ActionButton.swift
//  BlackJackPractice
//
//  Created by Victor Quach on 3/22/23.
//

import SwiftUI

struct ActionButton: View {
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    let buttonWidth: CGFloat = 180


    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .frame(width: buttonWidth)
                .background(backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}



struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                ActionButton(title: "Button title", backgroundColor: Color.blue, action: {
                    //
                })
                ActionButton(title: "Button title", backgroundColor: Color.red, action: {
                    //
                })
            }
            HStack {
                ActionButton(title: "Button title", backgroundColor: Color.green, action: {
                    //
                })
                ActionButton(title: "Button title", backgroundColor: Color.yellow, action: {
                    //
                })
            }
        }.preferredColorScheme(.dark) // Add this line to enable Dark mode by default
    }
}
