//
//  MenuView.swift
//  swiftui-wordsearch
//
//  Created by Jerome Bach on 18/05/2023.
//

import Foundation
import SwiftUI

struct MenuView: View {
    @AppStorage("score") var score: Int = 0
    @EnvironmentObject private var navigationState: NavigationState
    
    var body: some View {
        ZStack {
            LinearGradient.backgroundGradient.ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("WordSearch")
                    .font(.primaryTitle)
                Text("Recherche de mot")
                    .font(.primaryContent)
                let words: [String] = Dataset.testWords()
                var wordSearch = WordSearch(words: words)
                let wordSearchInfo = wordSearch.setup()
                NavigationLink(destination: MainRouter(routes: Routes.GameRoutes.game(wordSearch: wordSearchInfo)).configure()) {
                    Text("Start")
                }.buttonStyle(CustomButtonStyle())
            }
            .foregroundColor(.white)
            .padding()
        }
        .onAppear {
            score = 0
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
