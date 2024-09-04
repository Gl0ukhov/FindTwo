//
//  ThemeGame - ViewModel.swift
//  Memorize
//
//  Created by Матвей Глухов on 28.08.2024.
//

import SwiftUI

@Observable
class ThemeGame {
    var allTheme: [Theme] {
        didSet {
            autosave()
        }
    }
    
    private let url = URL.documentsDirectory.appending(path: "autosave.json")
    
    private func autosave() {
        save()
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(allTheme)
            try data.write(to: url)
        } catch {
            print("Failed save")
        }
    }
    
    init() {
        if let data = try? Data(contentsOf: url) {
            if let theme = try? JSONDecoder().decode([Theme].self, from: data) {
                allTheme = theme
                return
            }
        }
        allTheme = Theme.emojiTheme
    }
    
    func addNewTheme(name: String, color: Theme.RGBA, emojis: String) {
        allTheme.append(Theme(name: name, emojis: emojis, color: color))
    }
    
    func index(UUID: UUID) -> Int {
        allTheme.firstIndex { $0.id == UUID } ?? 0
    }
}


