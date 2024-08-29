//
//  ThemeGame - ViewModel.swift
//  Memorize
//
//  Created by Матвей Глухов on 28.08.2024.
//

import SwiftUI

@Observable
class ThemeGame {
    var allTheme: [Theme] = Theme.emojiTheme
    
    
}

extension Theme {
    var colorForView: Color {
        switch color {
        case "Green":  Color.green
        case "Black": Color.black
        case "Blue": Color.blue
        case "Purple": Color.purple
        case "Orange": Color.orange
        case "Mint": Color.mint
        default:  Color.black
        }
    }
}
