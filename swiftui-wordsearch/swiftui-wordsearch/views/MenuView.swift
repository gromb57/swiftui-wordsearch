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
    @EnvironmentObject private var loadingState: LoadingState
    @State var width: Int = 20
    @State var height: Int = 20
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimum = 1
        formatter.maximum = 20
        formatter.allowsFloats = false
        return formatter
    }()

    var body: some View {
        ZStack {
            LinearGradient.backgroundGradient.ignoresSafeArea()
            
            CardView(height: 250) {
                VStack(spacing: 10) {
                    Text("WordSearch")
                        .font(.primaryTitle)
                    Text("Recherche de mot")
                        .font(.primaryContent)
                    HStack {
                        Text("Largeur")
                        TextField("Largeur", value: self.$width, formatter: self.formatter)
                    }
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                    HStack {
                        Text("Hauteur")
                        TextField("Hauteur", value: self.$height, formatter: self.formatter)
                    }
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                    NavigationLink("Démarrer") {
                        self.newView()
                    }.buttonStyle(CustomButtonStyle())
                        .onSubmit {
                            loadingState.isLoading.toggle()
                        }
                }
            }
            .foregroundColor(.white)
            .padding()
        }
        .onAppear {
            score = 0
        }
    }

    func newView() -> some View {
        let words: [String] = Dataset.testWords()
        var wordSearch = WordSearch(words: words, width: self.width, height: self.height)
        let wordSearchInfo = wordSearch.setup()
        return MainRouter(routes: Routes.GameRoutes.game(wordSearch: wordSearchInfo)).configure()
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
