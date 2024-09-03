//
//  Theme - model.swift
//  Memorize
//
//  Created by Матвей Глухов on 24.06.2024.
//

import Foundation

struct Theme: Identifiable, Hashable {
    var name: String
    var emojis: String
    var color: RGBA
    let id = UUID()
    
    
    static var emojiTheme = [
        Theme(
            name: "Animal",
            emojis: "🐶🐭🐹🐰🦊🐮",
            color: RGBA(red: 0, green: 1, blue: 0, alpha: 1)),
        Theme(
            name: "Halloween",
            emojis: "👻🎃🧟‍♂️🕷️😵‍💫☠️🧛‍♂️",
            color: RGBA(red: 0, green: 0, blue: 0, alpha: 1)),
        ]
    
    struct RGBA: Codable, Equatable, Hashable {
        let red: Double
        let green: Double
        let blue: Double
        let alpha: Double
    }

}


