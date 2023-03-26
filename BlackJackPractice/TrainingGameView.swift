import SwiftUI
import BlackJackSharedCode


struct TrainingGameView: View {
    @State private var playerCard1: Card
    @State private var playerCard2: Card
    @State private var dealerCard: Card
    @State private var feedbackMessage: String
    @State private var backgroundColor: Color
    @State private var isHintVisible: Bool = false
    @State private var triggerDealerBackCardSwooshIn = false
    @State private var streakCount: Int
    @State private var highScore: Int

    
    let showDealButton = UserDefaults.standard.bool(forKey: "showDealButton")
    let autoDealEnabled = UserDefaults.standard.bool(forKey: "autoDealEnabled")
    let dealingSpeed = UserDefaults.standard.double(forKey: "dealingSpeed")
        
    let gameName: String
    let hintText: String
    let splitOnly: Bool
    let generatePlayerCards: () -> (Card, Card)
    
    let streakKey: String
    let highScoreKey: String
    
    init(gameName: String, hintText: String, generatePlayerCards: @escaping () -> (Card, Card), splitOnly: Bool = false) {
        self.gameName = gameName
        self.hintText = hintText
        self.generatePlayerCards = generatePlayerCards
        self.splitOnly = splitOnly
        let (card1, card2) = generatePlayerCards()
        _playerCard1 = State(initialValue: card1)
        _playerCard2 = State(initialValue: card2)
        dealerCard = Utility.randomCard()
        feedbackMessage = ""
        backgroundColor = .clear
        streakKey = "streakCount" + gameName
        highScoreKey = "streakCount" + gameName
        streakCount = UserDefaults.standard.integer(forKey: streakKey)
        highScore = UserDefaults.standard.integer(forKey: highScoreKey)
    }
    
    var body: some View {
        ZStack {
            GradientBackground()
            VStack(spacing: 16) {
                Text("Streak: \(streakCount), High: \(highScore)")
                Spacer()
                Text(feedbackMessage)
                HStack {
                    CardView(Card(rank:0, suit: .clubs), delay: dealingSpeed * 2, triggerSwooshIn: $triggerDealerBackCardSwooshIn)
                    CardView(dealerCard, delay: dealingSpeed * 6)
                }.font(.system(size:40))
                Spacer()
                HStack {
                    CardView(playerCard1)
                    CardView(playerCard2, delay: dealingSpeed * 4)
                }.font(.system(size:40))
                Spacer()
                
                
                if splitOnly {
                    SplitButtonsView(playerCard1: $playerCard1, playerCard2: $playerCard2, dealerCard: $dealerCard, feedbackMessage: $feedbackMessage, backgroundColor: $backgroundColor, onCorrectAction: {
                        streakCount += 1
                        highScore = max(streakCount, highScore)
                        if autoDealEnabled {
                            deal()
                        }
                        UserDefaults.standard.set(streakCount, forKey: streakKey)
                        UserDefaults.standard.set(streakCount, forKey: highScoreKey)

                    }, onIncorrectAction: {
                        streakCount = 0
                        UserDefaults.standard.set(streakCount, forKey: streakKey)
                    })
                } else {
                    ActionButtonsView(playerCard1: $playerCard1, playerCard2: $playerCard2, dealerCard: $dealerCard, feedbackMessage: $feedbackMessage, backgroundColor: $backgroundColor, onCorrectAction: {
                        streakCount += 1
                        highScore = max(streakCount, highScore)
                        if autoDealEnabled {
                            deal()
                        }
                        UserDefaults.standard.set(streakCount, forKey: streakKey)
                        UserDefaults.standard.set(streakCount, forKey: highScoreKey)

                    }, onIncorrectAction: {
                        streakCount = 0
                        UserDefaults.standard.set(streakCount, forKey: streakKey)
                    })
                }
                
                if showDealButton {
                    ActionButton(title: "Deal", backgroundColor: Color("Secondary"), action: {
                        deal()
                    })
                }
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
    
    func deal() {
        let (card1, card2) = generatePlayerCards()
        playerCard1 = card1
        playerCard2 = card2
        dealerCard = Utility.randomCard()
        triggerDealerBackCardSwooshIn = true
        feedbackMessage = ""
        backgroundColor = .clear
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

struct TradingView_Previews: PreviewProvider {
    static var previews: some View {
        SoftTotalsView().preferredColorScheme(.dark)
    }
}
