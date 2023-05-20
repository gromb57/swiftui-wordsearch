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
                // Text("\(score)")
                LazyHGrid(rows: self.rows) {
                    ForEach(wordSearch.grid, id: \.self) { column in
                        LazyVGrid(columns: column.map({ char in
                            GridItem(.flexible())
                        })) {
                            ForEach(column, id: \.self.id) { col in
                                Text(col.value)
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

    var rows: [GridItem] {
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
