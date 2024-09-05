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
    var choosingTheme: Theme
    
    init(choosingTheme: Theme, number: Int) {
        self.viewModel = EmojiMemoryGame(emoji: choosingTheme.emojis, numberOfCard: number)
        self.choosingTheme = choosingTheme
    }
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private var color: Color { return Color(RGBA: choosingTheme.color) }
    
    @State private var lastScoreChange = (0, causedByCardID: "")
    
    var body: some View {
        VStack {
            heading
            cards.foregroundStyle(color)
            score
            
        }
        .preferredColorScheme( color == .white ? .dark : .light)
        .padding(.horizontal, spacing)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        viewModel.newGame(emoji: choosingTheme.emojis, numberOfCard: choosingTheme.numberCard)
                    }
                } label: {
                    Text("New game")
                        .bold()
                }
            }
        }
        
        .onAppear(perform: viewModel.shuffle)
    }
    
    
    private var heading: some View {
        VStack {
            Text("Memorize")
                .font(.title)
                .foregroundStyle(color)
            Text("Theme is \(choosingTheme.name)")
                .font(.callout)
                .foregroundStyle(color)
        }
        .padding(.bottom, 40)
    }
    
    private var score: some View {
        Text("Your score: \(viewModel.score)")
            .font(.title2)
            .padding()
            .animation(.easeInOut, value: viewModel.score)
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    choose(card)
                }
        }
    }
    
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardID: card.id.description)
        }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id.description == id ? amount : 0
    }
}

