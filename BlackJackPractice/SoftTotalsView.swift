import SwiftUI

struct SoftTotalsView: View {
    @State private var playerCard1: Int
    @State private var playerCard2: Int
    @State private var dealerCard: Int
    @State private var feedbackMessage: String
    @State private var backgroundColor: Color
    @State private var isHintVisible: Bool = false
    
    private let hintText: String = """
    Double soft 13-14 against 5-6, otw hit
    Double soft 15-16 against 4-6, otw hit
    Double soft 17 against 3-6, otw hit
    Soft 18: double against 2-6, stands against 7-8, hits against 9, 10, Ace
    Soft 19: double against 6, otw stand
    Soft 20-21: stand
    """
    
    init() {
        playerCard1 = 1
        playerCard2 = Utility.randomCard()
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
                
                ActionButtonsView(playerCard1: $playerCard1, playerCard2: $playerCard2, dealerCard: $dealerCard, feedbackMessage: $feedbackMessage, backgroundColor: $backgroundColor)
                
                ActionButton(title: "Deal", backgroundColor: Color.green, action: {
                    playerCard1 = 1
                    playerCard2 = Utility.randomCard()
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

struct ActionButtonsView: View {
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

struct SoftTotalsView_Previews: PreviewProvider {
    static var previews: some View {
        SoftTotalsView().preferredColorScheme(.dark)
    }
}
