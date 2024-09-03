//
//  ThemeGameView.swift
//  Memorize
//
//  Created by Матвей Глухов on 28.08.2024.
//

import SwiftUI

struct ThemeGameView: View {
    
    @Environment (ThemeGame.self) var themes
    
    @State private var addTheme = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(themes.allTheme) { theme in
                        NavigationLink(value: theme) {
                            OneCellTheme(name: theme.name, emoji: theme.emojis.joined(), color: Color(RGBA: theme.color), number: theme.emojis.count)
                        }
                    }
                    .onDelete(perform: <#T##Optional<(IndexSet) -> Void>##Optional<(IndexSet) -> Void>##(IndexSet) -> Void#>)
                }
                .navigationDestination(for: Theme.self) { theme in
                    EmojiMemoryGameView(choosingTheme: theme)
                }
            }
            .sheet(isPresented: $addTheme, content: {
                AddTheme(theme: themes)
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

struct AddTheme: View {
    @Environment (\.dismiss) var dismiss
    @Bindable var theme: ThemeGame
    @FocusState private var nameFocus: Bool
    
    @State private var name = ""
    @State private var emoji = ""
    @State private var color: Color = .black
    private var disableAdd: Bool {
        if  emoji.count > 3 {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Choose a name") {
                    TextField("Name", text: $name)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()
                        .focused($nameFocus)
                    
                }
                Section("Add an emoji and choose a theme color") {
                    TextField("Add at least 4 emojis", text: $emoji)
                        .onChange(of: emoji, { oldValue, newValue in
                            emoji = (newValue + emoji)
                                .filter { $0.isEmoji }
                                .uniqued
                        })
                    ColorPicker("Color", selection: $color,supportsOpacity: true)
                    
                }
            }
            .onAppear {
                nameFocus = true
            }
            .navigationTitle("Add new theme")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        theme.addNewTheme(name: name, color: Theme.RGBA(color: color), emojis: emoji)
                        print(emoji)
                        print(theme)
                        dismiss()
                    }
                    .disabled(disableAdd)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
}

struct OneCellTheme: View {
    
    var name: String
    var emoji: String
    var color: Color
    var number: Int
    
    var body: some View {
        HStack {
            Image(systemName: "rectangle.fill")
                .foregroundStyle(color)
                .scaleEffect(CGSize(width: 2, height: 2))
            VStack(alignment: .leading) {
                HStack {
                    Text(name)
                    Text(emoji.prefix(5))
                }
                HStack {
                    Text("Number of cards: \(number)")
                }
            }
            .padding(.horizontal)
        }
    }
}


