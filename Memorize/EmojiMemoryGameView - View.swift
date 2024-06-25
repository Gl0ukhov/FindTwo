//
//  EmojiMemoryGameView - View.swift
//  Memorize
//
//  Created by Матвей Глухов on 13.06.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        NavigationStack {
            VStack {
                heading
                theme
                cards
                    .animation(.linear, value: viewModel.cards)
                score
                    .animation(.default, value: viewModel.score)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("New game") {
                        viewModel.newGame()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Shuffle") {
                        viewModel.shuffle()
                    }
                    
                }
            }
        }
        .onAppear(perform: viewModel.shuffle)
    }
    
    
    var heading: some View {
        Text("Memorize")
            .font(.title)
            .foregroundStyle(viewModel.themeColor)
    }
    
    var theme: some View {
        Text("Theme is \(EmojiMemoryGame.theme.topicName)")
            .font(.callout)
            .foregroundStyle(viewModel.themeColor)
    }
    
    var score: some View {
        Text("Your score: \(viewModel.score)")
            .font(.title2)
            .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundStyle(viewModel.themeColor)
    }
    
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base
                    .foregroundStyle(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1:0)
            base
                .fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatch ? 1 : 0)
    }
}



#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
