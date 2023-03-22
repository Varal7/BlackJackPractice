//
//  ContentView.swift
//  BlackJackPractice
//
//  Created by Victor Quach on 3/22/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            MenuView()
        }
    }
}

struct MenuView: View {
    let buttonWidth: CGFloat = 200

    var body: some View {
        VStack(spacing: 16) {
            NavigationLink(destination: SplitsView()) {
                Text("Splits")
                    .padding()
                    .frame(width: buttonWidth)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            NavigationLink(destination: SoftTotalsView()) {
                Text("Soft Totals")
                    .padding()
                    .frame(width: buttonWidth)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            NavigationLink(destination: HardTotalsView()) {
                Text("Hard Totals")
                    .padding()
                    .frame(width: buttonWidth)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().preferredColorScheme(.dark)
    }
}
