//
//  EmojiMemoryGameView - View.swift
//  Memorize
//
//  Created by Матвей Глухов on 13.06.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        NavigationStack {
            VStack {
                heading
                theme
                cards
                    .foregroundStyle(viewModel.themeColor)
                score
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
                        withAnimation {
                            viewModel.shuffle()
                        }
                    }
                    
                } 
            }
        }
        .onAppear(perform: viewModel.shuffle)
    }
    
    
    private var heading: some View {
        Text("Memorize")
            .font(.title)
            .foregroundStyle(viewModel.themeColor)
    }
    
    private var theme: some View {
        Text("Theme is \(EmojiMemoryGame.theme.topicName)")
            .font(.callout)
            .foregroundStyle(viewModel.themeColor)
    }
    
    private var score: some View {
        Text("Your score: \(viewModel.score)")
            .font(.title2)
            .padding()
            .animation(nil, value: viewModel.score)
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
        }
    }
  
    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
}









#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
