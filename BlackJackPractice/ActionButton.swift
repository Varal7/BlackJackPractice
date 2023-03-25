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
                .fontWeight(.semibold)
                .font(.system(size:24))
                .textCase(.uppercase)
                .padding()
                .frame(width: buttonWidth)
                .background(backgroundColor)
                .foregroundColor(Color("TextColor"))
                .cornerRadius(6)
        }
    }
}



struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            GradientBackground()
            
            VStack {
                HStack {
                    ActionButton(title: "Stand", backgroundColor: Color("Primary"), action: {
                        //
                    })
                    ActionButton(title: "Hit", backgroundColor: Color("Primary"), action: {
                        //
                    })
                }
                HStack {
                    ActionButton(title: "Title", backgroundColor: Color("Secondary"), action: {
                        //
                    })
                    ActionButton(title: "Deal", backgroundColor: Color("Secondary"), action: {
                        //
                    })
                }
            }.preferredColorScheme(.dark) // Add this line to enable Dark mode by default
        }
    }
}
