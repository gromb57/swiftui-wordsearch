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
    @State var taps: [Int:Bool] = [:]
    let size: CGSize = CGSize(width: 48, height: 48)
    
    var body: some View {
        ZStack {
            LinearGradient.backgroundGradient.ignoresSafeArea()
            VStack {
                HStack {
                    ForEach(wordSearch.words, id: \.self) { word in
                        Text(word)
                    }
                }
                // Text("\(score)")
                LazyHGrid(rows: self.rows) {
                    ForEach(wordSearch.grid, id: \.self) { column in
                        LazyVGrid(columns: column.map({ char in
                            GridItem(.fixed(size.height), spacing: 0)
                        })) {
                            ForEach(column, id: \.self.id) { col in
                                VStack {
                                    Text(col.value)
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                }
                                    .background(self.taps[col.id] == true ? .white : .clear)
                                    .clipShape(Circle())
                                    .foregroundColor(self.taps[col.id] == true ? .blue : .white)
                                    .onTapGesture {
                                        if self.taps[col.id] == true {
                                            self.taps[col.id] = false
                                        } else {
                                            self.taps[col.id] = true
                                        }
                                    }
                            }
                        }
                    }
                }._scrollable()
            }
            .foregroundColor(.white)
            .padding()
            //.toolbar(.hidden)
        }
    }

    var rows: [GridItem] {
        return self.wordSearch.grid.map { _ in
            return GridItem(.fixed(size.width))
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameView(wordSearch: WordSearch.WordSearchInfo(words: [], height: 10, width: 10, grid: [], solved: [], unplaced: []))
        }
        .navigationViewStyle(.stack)
    }
}
