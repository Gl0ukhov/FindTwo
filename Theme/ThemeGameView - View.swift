//
//  ThemeGameView.swift
//  Memorize
//
//  Created by Матвей Глухов on 28.08.2024.
//

import SwiftUI

struct ThemeGameView: View {
    
    
    @State private var themes = ThemeStore()
    
    @State private var addTheme = false
    @State private var editTheme = false
    
    @State private var indexTheme = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(themes.allTheme) { theme in
                        NavigationLink(value: theme) {
                            OneCellTheme(name: theme.name, emoji: theme.emojis, color: Color(RGBA: theme.color), number: theme.numberCard)
                                .swipeActions(edge: .leading) {
                                    Button("Edit") {
                                        editTheme.toggle()
                                        indexTheme = themes.index(UUID: theme.id)
                                    }
                                    .tint(.blue)
                                }
                        }
                    }
                    .onDelete { indexSet in
                        themes.allTheme.remove(atOffsets: indexSet)
                    }
                }
                .navigationDestination(for: Theme.self) { theme in
                    EmojiMemoryGameView(choosingTheme: theme, number: theme.numberCard)
                }
            }
            .sheet(isPresented: $addTheme, content: {
                AddTheme(theme: themes)
                    .font(nil)
            })
            .sheet(isPresented: $editTheme, content: {
                EditTheme(theme: $themes.allTheme[indexTheme], color: Color(RGBA: themes.allTheme[indexTheme].color))
                    .font(nil)
            })
            .navigationTitle("Choose a theme")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add theme") {
                        addTheme.toggle()
                    }
                }
            }
        }
    }
}


