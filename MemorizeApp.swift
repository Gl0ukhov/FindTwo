//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Матвей Глухов on 13.06.2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
//    var game = EmojiMemoryGame()
    @State private var theme = ThemeGame()
    
    var body: some Scene {
        WindowGroup {
            ThemeGameView()
                .environment(theme)
//            EmojiMemoryGameView(viewModel: game)
        }
    }
}
