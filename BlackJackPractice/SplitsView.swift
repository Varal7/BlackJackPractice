import SwiftUI

struct SplitsView: View {
    @State private var playerCard1: Card
    @State private var playerCard2: Card
    @State private var dealerCard: Card
    @State private var feedbackMessage: String
    @State private var backgroundColor: Color
    @State private var isHintVisible: Bool = false
    @State private var triggerDealerBackCardSwooshIn = false
    
    private let hintText: String = """
    Always split aces and 8s
    Never split 5s
    Split 2s, 3s, 7s against 2-7
    Split 4s against 5 or 6
    Split 6s against 2-6
    Split 9s against 2-6 and 8-9
    """

    
    init() {
        let card = Utility.randomCard()
        playerCard1 = card
        playerCard2 = Utility.randomCard(rank: card.rank)
        dealerCard = Utility.randomCard()
        feedbackMessage = ""
        backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            GradientBackground()
            VStack(spacing: 16) {
                Spacer()
                Text(feedbackMessage)
                HStack {
                    CardView(Card(rank:0, suit: .clubs), delay: 0.2, triggerSwooshIn: $triggerDealerBackCardSwooshIn)
                    CardView(dealerCard, delay: 0.6)
                }.font(.system(size:40))
                Spacer()
                HStack {
                    CardView(playerCard1)
                    CardView(playerCard2, delay: 0.4)
                }.font(.system(size:40))
                Spacer()
                
                SplitButtonsView(playerCard1: $playerCard1, playerCard2: $playerCard2, dealerCard: $dealerCard, feedbackMessage: $feedbackMessage, backgroundColor: $backgroundColor)
                ActionButton(title: "Deal", backgroundColor: Color("Secondary"), action: {
                    let card = Utility.randomCard()
                    playerCard1 = card
                    playerCard2 = Utility.randomCard(rank: card.rank)
                    dealerCard = Utility.randomCard()
                    triggerDealerBackCardSwooshIn = true
                    feedbackMessage = ""
                    backgroundColor = .clear
                })
            }
            .padding()
            .background(backgroundColor)
            .onTapGesture {
                if isHintVisible {
                    isHintVisible = false
                }
            }
            
            if isHintVisible {
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isHintVisible = false
                    }
                
                HintPopupView(hintText: hintText, onClose: {
                    isHintVisible = false
                })
            }
        }
        .navigationBarItems(trailing: hintButton)
    }
    
    private var hintButton: some View {
        Button(action: {
            isHintVisible.toggle()
        }) {
            Image(systemName: "questionmark.circle")
                .font(.system(size: 24))
                .foregroundColor(.blue)
        }
    }
}

struct SplitButtonsView: View {
    @Binding var playerCard1: Card
    @Binding var playerCard2: Card
    @Binding var dealerCard: Card
    @Binding var feedbackMessage: String
    @Binding var backgroundColor: Color
    
    let actions: [String] = ["Split", "Don't Split"]
    
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
            backgroundColor = .clear
        } else {
            feedbackMessage = "Incorrect. \(reason)"
            backgroundColor = Color("Danger")
        }
    }
}

struct SplitsView_Previews: PreviewProvider {
    static var previews: some View {
        SplitsView().preferredColorScheme(.dark)
    }
}

