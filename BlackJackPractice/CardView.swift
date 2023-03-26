//
//  CardView.swift
//  BlackJackPractice
//
//  Created by Victor Quach on 3/22/23.
//

import SwiftUI
import BlackJackSharedCode


struct CardView: View {
    let card: Card
    let delay: Double
    @Binding var triggerSwooshIn: Bool
    @State private var isSwooshedIn = false
    let dealingSpeed = UserDefaults.standard.double(forKey: "dealingSpeed")

    
    init(_ card: Card, delay: Double = 0, triggerSwooshIn: Binding<Bool> = .constant(false)) {
        self.card = card
        self.delay = delay
        _triggerSwooshIn = triggerSwooshIn
    }
    
    func cardRank(_ card: Card) -> String {
        switch card.rank {
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
            return String(card.rank)
        }
    }
    
    func cardSuit(_ card: Card) -> String {
        switch card.suit {
        case .spades:
            return "s"
        case .hearts:
            return "h"
        case .diamonds:
            return "d"
        case .clubs:
            return "c"
        }
    }
    
    func cardRankName(_ card: Card) -> String {
        switch card.rank {
        case 1:
            return "ace"
        case 10:
            return "10"
        case 11:
            return "jack"
        case 12:
            return "queen"
        case 13:
            return "king"
        default:
            return String(card.rank)
        }
    }
    
    func cardSuitName(_ card: Card) -> String {
        switch card.suit {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    
    func swooshIn() {
        isSwooshedIn = false
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation(.easeOut(duration: dealingSpeed)) {
                isSwooshedIn = true
            }
        }
        triggerSwooshIn = false
    }
    
    
    var body: some View {
        
        let name = card.rank < 1 || card.rank > 14 ? "card_back" :cardRankName(card) + "_of_" + cardSuitName(card)
        
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 120)
            .padding(4)
            .background(Color("WashedWhite"))
            .cornerRadius(8)
            .offset(x: isSwooshedIn ? 0 : UIScreen.main.bounds.width)
            .onAppear {
                swooshIn()
            }
            .onChange(of: name) { _ in
                swooshIn()
            }
            .onChange(of: triggerSwooshIn) { newValue in
                if newValue {
                    swooshIn()
                }
            }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            GradientBackground()
            VStack {
                HStack {
                    CardView(Card(rank: 1, suit: .clubs))
                    CardView(Card(rank: 2, suit: .clubs))
                    CardView(Card(rank: 3, suit: .clubs))
                    CardView(Card(rank: 4, suit: .clubs))
                }
                HStack {
                    CardView(Card(rank: 5, suit: .clubs))
                    CardView(Card(rank: 6, suit: .clubs))
                    CardView(Card(rank: 7, suit: .clubs))
                    CardView(Card(rank: 8, suit: .clubs))
                    
                }
                HStack {
                    CardView(Card(rank: 9, suit: .clubs))
                    CardView(Card(rank: 10, suit: .clubs))
                    CardView(Card(rank: 11, suit: .clubs))
                    CardView(Card(rank: 12, suit: .clubs))
                }
                HStack {
                    CardView(Card(rank: 13, suit: .clubs))
                    CardView(Card(rank: 0, suit: .clubs))
                    CardView(Card(rank: 0, suit: .clubs))
                    CardView(Card(rank: 0, suit: .clubs))
                }
            }.preferredColorScheme(.dark) // Add this line to enable Dark mode by default
        }
    }
}
