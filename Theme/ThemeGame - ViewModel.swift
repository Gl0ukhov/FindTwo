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
    
    func addNewTheme(name: String, color: Theme.RGBA, emojis: String) {
        allTheme.append(Theme(name: name, emojis: Array(emojis).map { "\($0)" }, color: color))
    }
    
    
}


