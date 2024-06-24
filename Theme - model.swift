//
//  Theme - model.swift
//  Memorize
//
//  Created by Матвей Глухов on 24.06.2024.
//

import Foundation

struct Theme {
    let topicName: String
    let emojiSet: [String]
    let numberOfEmojisAvailable: Int
    let colorOfCards: String
}

let themes = [
Theme(
    topicName: "Animal",
    emojiSet: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐮"],
    numberOfEmojisAvailable: 11,
    colorOfCards: "Green"),
Theme(
    topicName: "Halloween",
    emojiSet: ["👻", "🎃", "😈", "🧟‍♂️", "🕷️", "🕸️", "👹", "💀", "😵‍💫", "☠️", "🧛‍♂️", "🪳"],
    numberOfEmojisAvailable: 12,
    colorOfCards: "Black"),
Theme(
    topicName: "Fish",
    emojiSet: ["🐟", "🐠", "🐡", "🎏", "🎣", "🍤"],
    numberOfEmojisAvailable: 6,
    colorOfCards: "Blue"),
Theme(
    topicName: "Space",
    emojiSet: ["🔭", "🚀", "☄️", "🪐", "🛸", "🧑‍🚀", "👽"],
    numberOfEmojisAvailable: 7,
    colorOfCards: "Purple"),
Theme(
    topicName: "Food",
    emojiSet: ["🍔", "🌭", "🌮", "🌯", "🥙", "🥗", "🥪", "🍕", "🍟"],
    numberOfEmojisAvailable: 9,
    colorOfCards: "Orange"),
Theme(
    topicName: "Sport",
    emojiSet: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🏐", "🎾", "🏉"],
    numberOfEmojisAvailable: 8,
    colorOfCards: "Mint")
]
