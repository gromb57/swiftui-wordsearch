//
//  ResultsView.swift
//  swiftui-wordsearch
//
//  Created by Jerome Bach on 18/05/2023.
//

import Foundation
import SwiftUI

struct ResultsView: View {
    @EnvironmentObject private var navigationState: NavigationState
    let score: Int
    
    var body: some View {
        ZStack {
            LinearGradient.backgroundGradient.ignoresSafeArea()
            VStack(spacing: 10) {
                Text("Game result")
                    .font(.primaryTitle)
                Text("\(score)")
                    .font(.primaryTitle)
                Button("Play again") {
                    navigationState.routes.removeAll()
                }
                .buttonStyle(CustomButtonStyle())
            }
        }
        .foregroundColor(.white)
        //.toolbar(.hidden)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(score: 2)
    }
}
