//
//  CardView.swift
//  Memorize
//
//  Created by Матвей Глухов on 05.07.2024.
//

import SwiftUI


struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        TimelineView(.animation) { timeline in
            if card.isFaceUp || !card.isMatch {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay(
                        cardContent
                            .padding(Constants.Pie.inset)
                    )
                    .padding(Constants.insent)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
    
    var cardContent: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fill)
            .rotationEffect(.degrees(card.isMatch ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatch)
    }
    
    private struct Constants {
       
        static let insent: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 50
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 15
        }
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}

#Preview {
    VStack {
        HStack {
            CardView(MemoryGame<String>.Card(isFaceUp: true, content: "X", id: UUID()))
            CardView(MemoryGame<String>.Card(content: "X", id: UUID()))
        }
        HStack {
            CardView(MemoryGame<String>.Card(isFaceUp: true, content: "This is a very long string and I hope it fits", id: UUID()))
            CardView(MemoryGame<String>.Card(isMatch: true, content: "X", id: UUID()))
        }
    }
    .padding()
    .foregroundStyle(.green)
    
}
