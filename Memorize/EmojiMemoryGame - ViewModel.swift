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
    
    init(emoji: String, numberOfCard: Int) {
        
        model = EmojiMemoryGame.createMemoryGame(emoji: Array(emoji.map { "\($0)"}), number: numberOfCard)
    }
    
    private static func createMemoryGame(emoji: [String], number: Int) -> MemoryGame<String> {
        let noOfPairs = Int.random(in: 4...number)
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
    
    func newGame(emoji: String, numberOfCard: Int) {
        model = EmojiMemoryGame.createMemoryGame(emoji:  Array(emoji.map { "\($0)"}), number: numberOfCard)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }

}
