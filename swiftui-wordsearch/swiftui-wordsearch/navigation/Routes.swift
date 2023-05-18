//
//  Routes.swift
//  swiftui-quiz-game
//
//  Created by Jerome Bach on 18/05/2023.
//

import Foundation

enum Routes: Hashable {
    case mainNavigation(GameRoutes)
    
    enum GameRoutes: Hashable {
        case game(wordSearch: WordSearch.WordSearchInfo)
        case results(score: Int)
    }
}
