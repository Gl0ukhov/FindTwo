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
    private var model: MemoryGame<String>
    static var theme = themes.randomElement()!
    
    init() {
        model = EmojiMemoryGame.createMemoryGame(EmojiMemoryGame.theme)
    }

    
    private static func createMemoryGame(_ t: Theme) -> MemoryGame<String> {
        let emojis = t.emojiSet.shuffled()
        let noOfPairs = Int.random(in: 4...t.numberOfEmojisAvailable)
        return MemoryGame(numberOfPairsCards: noOfPairs) { index in
            if emojis.indices.contains(index) {
                emojis[index]
            } else {
                "⁉️"
            }
            
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var themeColor: Color {
        switch EmojiMemoryGame.theme.colorOfCards {
        case "Green":Color.green
        case "Black": Color.black
        case "Blue": Color.blue
        case "Purple": Color.purple
        case "Orange": Color.orange
        case "Mint": Color.mint
        default: Color.red
        }
    }
    
    
    func newGame() {
        EmojiMemoryGame.theme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(EmojiMemoryGame.theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    
    
    
}
