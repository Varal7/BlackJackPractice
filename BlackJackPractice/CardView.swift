//
//  CardView.swift
//  BlackJackPractice
//
//  Created by Victor Quach on 3/22/23.
//

import SwiftUI

struct CardView: View {
    let card: Int

    func cardName(_ card: Int) -> String {
        switch card {
        case 1:
            return "A"
        case 10:
            return "T"
        case 11:
            return "J"
        case 12:
            return "Q"
        case 13:
            return "K"
        default:
            return String(card)
        }
    }

    var body: some View {
        Text(cardName(card))
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                CardView(card: 1)
                CardView(card: 2)
                CardView(card: 3)
                CardView(card: 4)
                CardView(card: 5)
            }
            HStack {
                CardView(card: 6)
                CardView(card: 7)
                CardView(card: 8)
                CardView(card: 9)
                CardView(card: 10)
            }
            HStack {
                CardView(card: 11)
                CardView(card: 12)
                CardView(card: 13)
            }
        }.preferredColorScheme(.dark) // Add this line to enable Dark mode by default
    }
}
