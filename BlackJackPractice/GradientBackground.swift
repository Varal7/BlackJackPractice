import SwiftUI


struct GradientBackground: View {
    let startColor = Color("RussianViolet")
    let endColor = Color("RichBlack")


    var body: some View {
        LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}
