import SwiftUI


struct HardTotalsView: View {
    var body: some View {
        TrainingGameView(hintText: """
            17-21: stand
            13-16: stand against 2-6, otw hit
            12: stand against 4-6, otw hit
            11: double
            10: double against 2-9, otw hit
            9: double against 3-6, otw hit
            8 or less: hit
            """, generatePlayerCards: {
                (Utility.randomCard(excludingRank: 1), Utility.randomCard(excludingRank: 1))
            })
    }
}


struct HardTotalsView_Previews: PreviewProvider {
    static var previews: some View {
        HardTotalsView().preferredColorScheme(.dark)
    }
}
