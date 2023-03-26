import SwiftUI
import BlackJackSharedCode

struct SoftTotalsView: View {
    var body: some View {
        TrainingGameView(gameName: "SoftTotals", hintText: """
            Soft 13-14: double against 5-6, otw hit
            Soft 15-16: double against 4-6, otw hit
            Soft 17: double against 3-6, otw hit
            Soft 18: double against 2-6, stands against 7-8, hits against 9, 10, Ace
            Soft 19: double against 6, otw stand
            Soft 20-21: stand
            """, generatePlayerCards: {
                (Utility.randomCard(rank: 1), Utility.randomCard())
            })
    }
}

struct SoftTotalsView_Previews: PreviewProvider {
    static var previews: some View {
        SoftTotalsView().preferredColorScheme(.dark)
    }
}
