//
//  ThemeGameView.swift
//  Memorize
//
//  Created by Матвей Глухов on 28.08.2024.
//

import SwiftUI

struct ThemeGameView: View {
    
    @Environment (ThemeGame.self) var themes
    
    var body: some View {
        NavigationStack {
            List(themes.allTheme) { theme in
                NavigationLink(value: theme) {
                    oneCellTheme(name: theme.color, emoji: theme.emojis.joined(), color: theme.colorForView, number: theme.emojis.count)
                }
            }
            .navigationDestination(for: Theme.self, destination: { theme in
                //EmojiMemoryGameView
            })
            .navigationTitle("Choose a theme")
        }
    }
}

struct oneCellTheme: View {
    
    var name: String
    var emoji: String
    var color: Color
    var number: Int
    
    var body: some View {
        HStack {
            Image(systemName: "rectangle.fill.badge.checkmark")
                .foregroundStyle(color)
                .scaleEffect(CGSize(width: 2, height: 2))
            VStack(alignment: .leading) {
                HStack {
                    Text(name)
                    Text(emoji.prefix(5))
                }
                HStack {
                    Text("Number of cards: \(number)")
                }
            }
            .padding(.horizontal)
        }
    }
}

//#Preview {
//    ThemeGameView(themes: ThemeGame())
//}
