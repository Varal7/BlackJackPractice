import SwiftUI

struct SplitsView: View {
    @State private var playerCard1: Int
    @State private var playerCard2: Int
    @State private var dealerCard: Int
    @State private var feedbackMessage: String
    @State private var backgroundColor: Color
    @State private var isHintVisible: Bool = false
    
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
        playerCard2 = card
        dealerCard = Utility.randomCard()
        feedbackMessage = ""
        backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
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
                
                SplitButtonsView(playerCard1: $playerCard1, playerCard2: $playerCard2, dealerCard: $dealerCard, feedbackMessage: $feedbackMessage, backgroundColor: $backgroundColor)
                
                ActionButton(title: "Deal", backgroundColor: Color.green, action: {
                    let newCard = Utility.randomCard()
                    playerCard1 = newCard
                    playerCard2 = newCard
                    dealerCard = Utility.randomCard()
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
    @Binding var playerCard1: Int
    @Binding var playerCard2: Int
    @Binding var dealerCard: Int
    @Binding var feedbackMessage: String
    @Binding var backgroundColor: Color
    
    let actions: [String] = ["Split", "Don't Split"]
    
    var body: some View {
        HStack {
            ForEach(actions, id: \.self) { action in
                ActionButton(title: action, backgroundColor: Color.blue, action: {
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
            backgroundColor = .red
        }
    }
}

struct SplitsView_Previews: PreviewProvider {
    static var previews: some View {
        SplitsView().preferredColorScheme(.dark)
    }
}
