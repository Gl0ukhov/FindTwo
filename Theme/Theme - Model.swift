//
//  Theme - model.swift
//  Memorize
//
//  Created by Матвей Глухов on 24.06.2024.
//

import Foundation

struct Theme: Identifiable, Hashable {
    var name: String
    var emojis: [String]
    var color: RGBA
    let id = UUID()
    
    
    static var emojiTheme = [
        Theme(
            name: "Animal",
            emojis: ["🐶", "🐭", "🐹", "🐰", "🦊", "🐮"],
            color: RGBA(red: 0, green: 1, blue: 0, alpha: 1)),
        Theme(
            name: "Halloween",
            emojis: ["👻", "🎃", "🧟‍♂️", "🕷️", "😵‍💫", "☠️", "🧛‍♂️"],
            color: RGBA(red: 0, green: 0, blue: 0, alpha: 1)),
        Theme(
            name: "Fish",
            emojis: ["🐟", "🐠", "🐡", "🎏", "🎣", "🍤"],
            color: RGBA(red: 0, green: 0, blue: 1, alpha: 1)),
        Theme(
            name: "Space",
            emojis: ["🔭", "🚀", "☄️", "🪐", "🛸", "🧑‍🚀", "👽"],
            color: RGBA(red: 0.5, green: 0, blue: 0.5, alpha: 1)),
        Theme(
            name: "Food",
            emojis: ["🍔", "🌭", "🌮", "🌯", "🥙", "🥗", "🥪", "🍕"],
            color: RGBA(red: 1, green: 0, blue: 0, alpha: 1)),
        Theme(
            name: "Sport",
            emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🏐", "🎾", "🏉"],
            color: RGBA(red: 0, green: 0.8, blue: 0.3, alpha: 1))
        ]
    
    struct RGBA: Codable, Equatable, Hashable {
        let red: Double
        let green: Double
        let blue: Double
        let alpha: Double
    }

}


