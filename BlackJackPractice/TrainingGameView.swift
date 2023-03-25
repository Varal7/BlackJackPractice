import SwiftUI

struct TrainingGameView: View {
    @State private var playerCard1: Card
    @State private var playerCard2: Card
    @State private var dealerCard: Card
    @State private var feedbackMessage: String
    @State private var backgroundColor: Color
    @State private var isHintVisible: Bool = false
    @State private var triggerDealerBackCardSwooshIn = false
    
    let hintText: String
    let splitOnly: Bool
    let generatePlayerCards: () -> (Card, Card)
    
    init(hintText: String, generatePlayerCards: @escaping () -> (Card, Card), splitOnly: Bool = false) {
        self.hintText = hintText
        self.generatePlayerCards = generatePlayerCards
        self.splitOnly = splitOnly
        let (card1, card2) = generatePlayerCards()
        _playerCard1 = State(initialValue: card1)
        _playerCard2 = State(initialValue: card2)
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
                
                
                if splitOnly {
                    SplitButtonsView(playerCard1: $playerCard1, playerCard2: $playerCard2, dealerCard: $dealerCard, feedbackMessage: $feedbackMessage, backgroundColor: $backgroundColor)
                } else {
                    ActionButtonsView(playerCard1: $playerCard1, playerCard2: $playerCard2, dealerCard: $dealerCard, feedbackMessage: $feedbackMessage, backgroundColor: $backgroundColor)
                }
                
                ActionButton(title: "Deal", backgroundColor: Color("Secondary"), action: {
                    let (card1, card2) = generatePlayerCards()
                    playerCard1 = card1
                    playerCard2 = card2
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
