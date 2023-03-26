import SwiftUI
import BlackJackSharedCode


struct SplitsView: View {
    var body: some View {
        TrainingGameView(gameName: "Splits", hintText: """
            Always split aces and 8s
            Never split 5s
            Split 2s, 3s, 7s against 2-7
            Split 4s against 5 or 6
            Split 6s against 2-6
            Split 9s against 2-6 and 8-9
            """, generatePlayerCards: {
                let card = Utility.randomCard()
                return (card, Utility.randomCard(rank: card.rank))
            }, splitOnly: true
                    
        )
    }
}

struct SplitButtonsView: View {
    @Binding var playerCard1: Card
    @Binding var playerCard2: Card
    @Binding var dealerCard: Card
    @Binding var feedbackMessage: String
    @Binding var backgroundColor: Color

    let actions: [String] = ["Split", "Don't Split"]
    
    var onCorrectAction: () -> Void
    var onIncorrectAction: () -> Void
    
    var body: some View {
        HStack {
            ForEach(actions, id: \.self) { action in
                ActionButton(title: action, backgroundColor: Color("Primary"), action: {
                    handleAction(action: action)
                })
            }
        }
    }
    
    private func handleAction(action: String) {
        let (shouldSplit, reason) = Utility.shouldSplitCards(playerCard1: playerCard1, playerCard2: playerCard2, dealerCard: dealerCard)
        if (action == "Split" && shouldSplit) || (action == "Don't Split" && !shouldSplit) {
            feedbackMessage = "Correct! \(reason)"
            onCorrectAction()
            backgroundColor = .clear
        } else {
            feedbackMessage = "Incorrect. \(reason)"
            onIncorrectAction()
            backgroundColor = Color("Danger")
        }
    }
}

struct SplitsView_Previews: PreviewProvider {
    static var previews: some View {
        SplitsView().preferredColorScheme(.dark)
    }
}
