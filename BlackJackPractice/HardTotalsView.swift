import SwiftUI

struct HardTotalsView: View {
    @State private var playerCard1: Card
    @State private var playerCard2: Card
    @State private var dealerCard: Card
    @State private var feedbackMessage: String
    @State private var backgroundColor: Color
    @State private var isHintVisible: Bool = false
    @State private var triggerDealerBackCardSwooshIn = false
    
    private let hintText: String = """
    17-21: stand
    13-16: stand against 2-6, otw hit
    13-16: stand against 2-6, otw hit
    12: stand against 4-6, otw hit
    12: stand against 4-6, otw hit
    11: double
    10: double against 2-9, otw hit
    10: double against 2-9, otw hit
    9: double against 3-6, otw hit
    9: double against 3-6, otw hit
    8 or less: hit
    """
    
    init() {
        playerCard1 = Utility.randomCard(excludingRank: 1)
        playerCard2 = Utility.randomCard(excludingRank: 1)
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
                

                
                ActionButtonsView(playerCard1: $playerCard1, playerCard2: $playerCard2, dealerCard: $dealerCard, feedbackMessage: $feedbackMessage, backgroundColor: $backgroundColor)
                
                ActionButton(title: "Deal", backgroundColor: Color("Secondary"), action: {
                    playerCard1 = Utility.randomCard(excludingRank: 1)
                    playerCard2 = Utility.randomCard(excludingRank: 1)
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

struct HardTotalsView_Previews: PreviewProvider {
    static var previews: some View {
        HardTotalsView().preferredColorScheme(.dark)
    }
}
