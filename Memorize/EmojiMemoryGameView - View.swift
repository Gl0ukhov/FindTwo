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
                
                    .scrollIndicators(.hidden)
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
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(count: viewModel.cards.count, size: geometry.size, atAspectRatio: aspectRatio)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .foregroundStyle(viewModel.themeColor)
        }
    }
    
    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1.0
        let count = CGFloat(count)
        repeat {
            let width = size.width / columnCount
            let height = width / atAspectRatio
            let rowCount = (count / columnCount).rounded(.up)
            
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / CGFloat(count), size.height * atAspectRatio).rounded(.down)
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
