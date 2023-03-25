//
//  ActionButtonsView.swift
//  BlackJackPractice
//
//  Created by Victor Quach on 3/25/23.
//

import SwiftUI

struct ActionButtonsView: View {
    @Binding var playerCard1: Card
    @Binding var playerCard2: Card
    @Binding var dealerCard: Card
    @Binding var feedbackMessage: String
    @Binding var backgroundColor: Color
    
    let actions: [Utility.Action] = [.stand, .hit, .split, .double]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(Array(0..<(actions.count / 2)), id: \.self) { index in
                HStack {
                    ForEach(Array(0..<2), id: \.self) { subIndex in
                        let action = actions[index * 2 + subIndex]
                        ActionButton(title: action.rawValue.capitalized, backgroundColor: Color("Primary"), action: {
                            handleAction(action: action)
                        })
                    }
                }
            }
        }
    }
    
    private func handleAction(action: Utility.Action) {
        let (correctAction, reason) = Utility.getAction(playerCard1: playerCard1, playerCard2: playerCard2, dealerCard: dealerCard)
        if action == correctAction {
            feedbackMessage = "Correct! \(reason)"
            backgroundColor = .clear
        } else {
            feedbackMessage = "Incorrect. \(reason)"
            backgroundColor = Color("Danger")
        }
    }
}

struct ActionButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            GradientBackground()
            ActionButtonsView(
                playerCard1: .constant(Card(rank: 8, suit: .hearts)),
                playerCard2: .constant(Card(rank: 10, suit: .diamonds)),
                dealerCard: .constant(Card(rank: 1, suit: .spades)),
                feedbackMessage: .constant(""),
                backgroundColor: .constant(.clear)
            )
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}
