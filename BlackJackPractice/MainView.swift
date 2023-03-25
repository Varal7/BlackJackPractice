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
        ZStack {
            GradientBackground()
            
            VStack(spacing: 32) {
                NavigationLink(destination: SplitsView()) {
                    Text("Splits")
                        .fontWeight(.medium)
                        .font(.system(size:24))
                        .padding()
                        .frame(width: buttonWidth)
                        .background(Color("Primary"))
                        .foregroundColor(Color("TextColor"))
                        .cornerRadius(6)
                }
                
                NavigationLink(destination: SoftTotalsView()) {
                    Text("Soft Totals")
                        .fontWeight(.medium)
                        .font(.system(size:24))
                        .padding()
                        .frame(width: buttonWidth)
                        .background(Color("Primary"))
                        .foregroundColor(Color("TextColor"))
                        .cornerRadius(6)
                }
                
                NavigationLink(destination: HardTotalsView()) {
                    Text("Hard Totals")
                        .fontWeight(.medium)
                        .font(.system(size:24))
                        .padding()
                        .frame(width: buttonWidth)
                        .background(Color("Primary"))
                        .foregroundColor(Color("TextColor"))
                        .cornerRadius(6)
                }
            }
            .padding()
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().preferredColorScheme(.dark)
    }
}
