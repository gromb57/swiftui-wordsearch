//
//  MainRouter.swift
//  swiftui-quiz-game
//
//  Created by Jerome Bach on 18/05/2023.
//

import SwiftUI

struct MainRouter {
    let routes: Routes.GameRoutes
    
    @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .game(let wordSearch):
            GameView(wordSearch: wordSearch)
        case .results(let score):
            ResultsView(score: score)
        }
    }
}
