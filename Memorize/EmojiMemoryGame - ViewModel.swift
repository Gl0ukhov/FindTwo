//
//  EmojiMemoryGame - ViewModel.swift
//  Memorize
//
//  Created by Матвей Глухов on 17.06.2024.
//

import Foundation
import SwiftUI

@Observable
class EmojiMemoryGame {
    typealias Card = MemoryGame<String>.Card
    var theme: Theme
    
    private var model: MemoryGame<String>
    
    init() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = theme.emojis
        let noOfPairs = Int.random(in: 4...theme.numberOfEmojisAvailable)
        return MemoryGame(numberOfPairsCards: noOfPairs) { index in
            if emojis.indices.contains(index) {
                emojis[index]
            } else {
                "⁉️"
            }
            
        }
    }
    
    var cards: [Card] {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
//    var themeColor: Color {
//        switch theme.color {
//        case "Green":Color.green
//        case "Black": Color.black
//        case "Blue": Color.blue
//        case "Purple": Color.purple
//        case "Orange": Color.orange
//        case "Mint": Color.mint
//        default: Color.red
//        }
//    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(EmojiMemoryGame.theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }

}
