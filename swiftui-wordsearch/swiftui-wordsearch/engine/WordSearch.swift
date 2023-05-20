//
//  WordSearch.swift
//  swiftui-wordsearch
//
//  Created by Jerome Bach on 18/05/2023.
//

import Foundation

struct WordSearch {
    static let LETTERS = "abcdefghijklmnopqrstuvwxyz" // letters used for filler
    static let WORD_RE = "[a-z]+"                 // what a valid word looks like
    static let MAXATTEMPTS = 20                       // maximum amount of times to place a word

    enum Opts: String {
        case backwards
        case letters
    }
    
    struct DirectionInfo {
        var maxx: Int
        var maxy: Int
        var minx: Int
        var miny: Int
        var dx: Int
        var dy: Int
    }
    
    typealias Grid = [[Letter]]
    
    struct WordSearchInfo: Hashable {
        var grid: Grid
        var solved: Grid
        var unplaced: [String]
    }

    struct Letter: Hashable {
        var value: String
        var id: Int
    }
    
    var words: [String]
    var width: Int = 20
    var height: Int = 20
    var opts: [Opts:Any] = [
        .backwards: 0.5,
        .letters: WordSearch.LETTERS
    ]
    
    var backwards: Float {
        return self.opts[Opts.backwards] as? Float ?? 0.5
    }
    var letters: [String] {
        return (self.opts[Opts.backwards] as? String ?? WordSearch.LETTERS).map{String($0)}
    }

    mutating func setup() -> WordSearchInfo {
        // filter out any non-words
        self.words = self.words.filter({ word in
            guard let regex = try? NSRegularExpression(pattern: WordSearch.WORD_RE) else {
                return false
            }
            let results = regex.matches(in: word, range: NSRange(location: 0, length: word.count))
            
            return results.count > 0
        })

        // sort the words by length (biggest first)
        self.words.sort { a, b in
            return a.count < b.count
        }

        // populate the grid with empty arrays
        var grid: Grid = Array(repeating: Array(repeating: Letter(value: "", id: 0), count: self.width), count: self.height)

        var unplaced: [String] = []

        // loop the words
        var colorno = 0
        for i in 0..<self.words.count {
            let originalWord: String = self.words[i]
            var word: String = originalWord

            // reverse the word if needed
            if Float.random(in: 0...1) < self.backwards {
                word = word.components(separatedBy: "").reversed().joined(separator: "")
            }

            // pick a random spot
            // try to place the word in the grid
            var attempts: Int = 0
            while attempts < WordSearch.MAXATTEMPTS {
                // determine the direction (up-right, right, down-right, down)
                let direction: Int = Int.random(in: 0..<4)
                let info: DirectionInfo = self.directionInfo(word: word, direction: direction, width: self.width, height: self.height)

                // word is too long, bail out
                if info.maxx < 0 || info.maxy < 0 || info.maxy < info.miny || info.maxx < info.minx {
                    unplaced.append(originalWord)
                    break
                }

                // random starting point
                let ox: Int = Int(round(Float.random(in: 0...1) * Float(info.maxx - info.minx) + Float(info.minx)))
                var x: Int = ox
                let oy: Int = Int(round(Float.random(in: 0...1) * Float(info.maxy - info.miny) + Float(info.miny)))
                var y: Int = oy

                // check to make sure there are no collisions
                var placeable: Bool = true
                var count: Int = 0
                let wordAsArray: [String] = word.map{String($0)}
                for l in 0..<word.count {
                    let charInGrid: String = grid[y][x].value

                    if !charInGrid.isEmpty { // check if there is a character in the grid
                        if charInGrid != wordAsArray[l] {
                          // not the same latter, try again
                          placeable = false // :(
                          break
                        } else {
                            // same letter! count it
                            count += 1
                        }
                    }
                    // keep trying!
                    y += info.dy
                    x += info.dx
                }
                if !placeable || count >= word.count {
                    attempts += 1
                    continue
                }

                // the word was placeable if we make it here!
                // reset x and y and place it
                x = ox
                y = oy
                for l in 0..<word.count {
                    grid[y][x].value = wordAsArray[l]
                    /*if opts.color {
                        grid[y][x] = "\033[" + (colorno + 41) + "m" + grid[y][x] + "\033[0m"
                    }*/

                    y += info.dy
                    x += info.dx
                }
                break
            } // end placement while loop

            if attempts >= WordSearch.MAXATTEMPTS {
                unplaced.append(originalWord)
            }
            colorno = (colorno + 1) % 6
        } // end word loop

        // the solved grid
        var solved: Grid = grid

        // put in filler characters
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                grid[i][j].id = (i + 1) * j
                if grid[i][j].value.isEmpty {
                    solved[i][j].value = " "
                    let rand: Int = Int.random(in: 0..<self.letters.count)
                    grid[i][j].value = self.letters[rand]
                }
            }
        }

        // give the user some stuff
        return WordSearchInfo(grid: grid, solved: solved, unplaced: unplaced)
    }

    /**
     * given an integer that represents a direction,
     * return an object with boundary information
     * and velocity
     * - Parameters:
     *   - word: String
     *   - direction: Int
     *   - width: Int
     *   - height: Int
     * - Returns: DirectionInfo
     */
    func directionInfo(word: String, direction: Int, width: Int, height: Int) -> DirectionInfo {
        // determine the bounds
        var minx: Int = 0
        var miny: Int = 0
        var maxx: Int = width - 1
        var maxy: Int = height - 1
        var dx: Int = 0
        var dy: Int = 0
        
        switch (direction) {
        case 0: // up-right
            maxy = height - 1
            miny = word.count - 1
            dy = -1
            maxx = width - word.count
            minx = 0
            dx = 1
            break
        case 1: // right
            maxx = width - word.count
            minx = 0
            dx = 1
            break
        case 2: // down-right
            miny = 0
            maxy = height - word.count
            dy = 1
            maxx = width - word.count
            minx = 0
            dx = 1
            break
        case 3: // down
            miny = 0
            maxy = height - word.count
            dy = 1
            break
        default: /* NOTREACHED */
            break
        }

        return DirectionInfo(maxx: maxx, maxy: maxy, minx: minx, miny: miny, dx: dx, dy: dy)
    }
}
