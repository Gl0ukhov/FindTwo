//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Матвей Глухов on 13.06.2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
