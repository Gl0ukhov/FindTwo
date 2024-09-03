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
    
    init(emoji: String) {
        
        model = EmojiMemoryGame.createMemoryGame(emoji: Array(emoji.map { "\($0)"}))
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
    
    func newGame(emoji: String) {
        model = EmojiMemoryGame.createMemoryGame(emoji:  Array(emoji.map { "\($0)"}))
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }

}
