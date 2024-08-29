//
//  Theme - model.swift
//  Memorize
//
//  Created by Матвей Глухов on 24.06.2024.
//

import Foundation

struct Theme: Identifiable, Hashable {
    let name: String
    let emojis: [String]
    let color: String
    let id = UUID()
    
    static var emojiTheme = [
        Theme(
            name: "Animal",
            emojis: ["🐶", "🐭", "🐹", "🐰", "🦊", "🐮"],
            color: "Green"),
        Theme(
            name: "Halloween",
            emojis: ["👻", "🎃", "🧟‍♂️", "🕷️", "😵‍💫", "☠️", "🧛‍♂️"],
            color: "Black"),
        Theme(
            name: "Fish",
            emojis: ["🐟", "🐠", "🐡", "🎏", "🎣", "🍤"],
            color: "Blue"),
        Theme(
            name: "Space",
            emojis: ["🔭", "🚀", "☄️", "🪐", "🛸", "🧑‍🚀", "👽"],
            color: "Purple"),
        Theme(
            name: "Food",
            emojis: ["🍔", "🌭", "🌮", "🌯", "🥙", "🥗", "🥪", "🍕"],
            color: "Orange"),
        Theme(
            name: "Sport",
            emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🏐", "🎾", "🏉"],
            color: "Mint")
        ]

}

