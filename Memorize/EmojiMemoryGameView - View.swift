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
    
    init(choosingTheme: Theme) {
        self.viewModel = EmojiMemoryGame(emoji: choosingTheme.emojis)
        self.choosingTheme = choosingTheme
    }
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let dealAnimation: Animation = .easeOut(duration: 1)
    private let dealInterval: TimeInterval = 0.10
    private let deckWidth: CGFloat = 50
    
    @State private var dealt = Set<Card.ID>()
    @State private var lastScoreChange = (0, causedByCardID: "")
    
    @Namespace private var dealiingNamespace
    
    private var undealCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    var body: some View {
        VStack {
                heading
                cards.foregroundStyle(Color(RGBA: choosingTheme.color))
                score
//                deck.foregroundStyle(choosingTheme.colorForView)
                
            }
        .padding(.horizontal, 5)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.7)) {
                            viewModel.newGame(emoji: choosingTheme.emojis)
                        }
                    } label: {
                        Text("New game")
                            .bold()
                    }
                }
                
                
                
//                ToolbarItem(placement: .topBarLeading) {
//                    Button("Shuffle") {
//                        withAnimation {
//                            viewModel.shuffle()
//                        }
//                    }
//                    
//                }
            }

                .onAppear(perform: viewModel.shuffle)
    }
    
    
    private var heading: some View {
        VStack {
            Text("Memorize")
                .font(.title)
                .foregroundStyle(Color(RGBA: choosingTheme.color))
            Text("Theme is \(choosingTheme.name)")
                .font(.callout)
                .foregroundStyle(Color(RGBA: choosingTheme.color))
        }
        .padding(.bottom, 40)
    }
    
    private var score: some View {
        Text("Your score: \(viewModel.score)")
            .font(.title2)
            .padding()
            .animation(nil, value: viewModel.score)
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
//            if isDealt(card) {
                CardView(card)
//                    .matchedGeometryEffect(id: card.id, in: dealiingNamespace)
//                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .onTapGesture {
                        choose(card)
                    }
//            }
        }
    }
    
//    private var deck: some View {
//        ZStack {
//            ForEach(undealCards) { card in
//                CardView(card)
//                    .matchedGeometryEffect(id: card.id, in: dealiingNamespace)
//                    .transition(.asymmetric(insertion: .identity, removal: .identity))
//            }
//        }
//        .frame(width: deckWidth, height: deckWidth / aspectRatio)
//        .onTapGesture {
//            deal()
//        }
//    }
    
    
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                let _ = dealt.insert(card.id)
            }
            delay += dealInterval
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

