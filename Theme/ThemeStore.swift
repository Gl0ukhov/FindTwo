//
//  ThemeGame - ViewModel.swift
//  Memorize
//
//  Created by Матвей Глухов on 28.08.2024.
//

import SwiftUI

@Observable
class ThemeStore {
    var allTheme: [Theme] {
        didSet {
            autosave()
        }
    }
    
    private let url = URL.documentsDirectory.appending(path: "autosave.json")
    
    private func autosave() {
        save(url: url)
    }
    
    private func save(url: URL) {
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
    
    func addNewTheme(name: String, color: Theme.RGBA, emojis: String, numberCard: Int) {
        allTheme.append(Theme(name: name, emojis: emojis, color: color, numberCard: numberCard))
    }
    
    func index(UUID: UUID) -> Int {
        allTheme.firstIndex { $0.id == UUID } ?? 0
    }
}


