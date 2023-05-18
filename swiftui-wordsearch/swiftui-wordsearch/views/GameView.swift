//
//  GameView.swift
//  swiftui-wordsearch
//
//  Created by Jerome Bach on 18/05/2023.
//

import Foundation
import SwiftUI

struct GameView: View {
    @EnvironmentObject private var navigationState: NavigationState
    @AppStorage("score") var score: Int = 0
    let wordSearch: WordSearch.WordSearchInfo
    
    var body: some View {
        ZStack {
            LinearGradient.backgroundGradient.ignoresSafeArea()
            VStack {
                Text("\(score)")
                LazyVGrid(columns: self.columns) {
                    ForEach(wordSearch.grid, id: \.self) { row in
                        LazyHGrid(rows: row.map({ char in
                            GridItem(.flexible())
                        })) {
                            ForEach(row, id: \.self) { col in
                                Text(col)
                            }
                        }
                    }
                }
            }
            .foregroundColor(.white)
            .padding()
            //.toolbar(.hidden)
        }
    }

    var columns: [GridItem] {
        return self.wordSearch.grid.map { _ in
            return GridItem(.flexible())
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameView(wordSearch: WordSearch.WordSearchInfo(grid: [], solved: [], unplaced: []))
        }
        .navigationViewStyle(.stack)
    }
}
