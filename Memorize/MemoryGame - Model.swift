//
//  MemorizeGame - Model.swift
//  Memorize
//
//  Created by Матвей Глухов on 17.06.2024.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card] = []
    private(set) var score = 0
    
    init(numberOfPairsCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsCards x 2 cards
        
        for pairIndex in 0..<max(2, numberOfPairsCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1) a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1) b"))
        }
        cards.shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatch {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatch = true
                        cards[potentialMatchIndex].isMatch = true
                        score += 2
                    } else if cards[chosenIndex].content != cards[potentialMatchIndex].content {
                        if cards[potentialMatchIndex].viewed && cards[chosenIndex].viewed {
                            score -= 2
                        } else if cards[potentialMatchIndex].viewed || cards[chosenIndex].viewed {
                            score -= 1
                        }
                        cards[chosenIndex].viewed = true
                        cards[potentialMatchIndex].viewed = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatch ? "matched" : "no")"
        }
        
        var isFaceUp = true
        // Поправить на false
        var isMatch = false
        var viewed = false
        let content: CardContent
        
        var id: String
    }
}


extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
