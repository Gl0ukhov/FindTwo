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
    
    private var model: MemoryGame<String>
    
    init(emoji: [String]) {
        model = EmojiMemoryGame.createMemoryGame(emoji: emoji)
    }
    
    private static func createMemoryGame(emoji: [String]) -> MemoryGame<String> {
        let noOfPairs = Int.random(in: 4...emoji.count)
        return MemoryGame(numberOfPairsCards: noOfPairs) { index in
            if emoji.indices.contains(index) {
                emoji[index]
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
    
    func newGame(emoji: [String]) {
        model = EmojiMemoryGame.createMemoryGame(emoji: emoji)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }

}
