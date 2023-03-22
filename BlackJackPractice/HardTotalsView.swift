import SwiftUI

struct HardTotalsView: View {
    @State private var playerCard1: Int
    @State private var playerCard2: Int
    @State private var dealerCard: Int
    @State private var feedbackMessage: String
    @State private var backgroundColor: Color
    
    init() {
        (playerCard1, playerCard2) = HardTotalsView.randomHardTotalCards()
        dealerCard = Utility.randomCard()
        feedbackMessage = ""
        backgroundColor = .clear
    }
    
    static func randomHardTotalCards() -> (Int, Int) {
        // Just make it so that there is no Ace
        let cardValues = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
        let playerCard1 = cardValues.randomElement()!
        let playerCard2 = cardValues.randomElement()!
        return (playerCard1, playerCard2)
    }

    
    var body: some View {
        VStack(spacing: 16) {
            Text(feedbackMessage)
            HStack {
                Text("Dealer: ")
                CardView(card: dealerCard)
            }
            HStack {
                Text("You: ")
                CardView(card: playerCard1)
                CardView(card: playerCard2)
            }
            
            ActionButtonsView(playerCard1: $playerCard1, playerCard2: $playerCard2, dealerCard: $dealerCard, feedbackMessage: $feedbackMessage, backgroundColor: $backgroundColor)
            
            ActionButton(title: "Deal", backgroundColor: Color.green, action: {
                (playerCard1, playerCard2) = HardTotalsView.randomHardTotalCards()
                dealerCard = Utility.randomCard()
                feedbackMessage = ""
                backgroundColor = .clear
            })
        }
        .padding()
        .background(backgroundColor)
    }
}

struct HardButtonsView: View {
    @Binding var playerCard1: Int
    @Binding var playerCard2: Int
    @Binding var dealerCard: Int
    @Binding var feedbackMessage: String
    @Binding var backgroundColor: Color
    
    let actions: [Utility.Action] = [.stand, .hit, .split, .double]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(Array(0..<(actions.count / 2)), id: \.self) { index in
                HStack {
                    ForEach(Array(0..<2), id: \.self) { subIndex in
                        let action = actions[index * 2 + subIndex]
                        ActionButton(title: action.rawValue.capitalized, backgroundColor: Color.blue, action: {
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
            backgroundColor = .red
        }
    }
}

struct HardTotalsView_Previews: PreviewProvider {
    static var previews: some View {
        HardTotalsView().preferredColorScheme(.dark)
    }
}
