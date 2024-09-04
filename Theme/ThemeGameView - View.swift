//
//  ThemeGameView.swift
//  Memorize
//
//  Created by Матвей Глухов on 28.08.2024.
//

import SwiftUI

struct ThemeGameView: View {
    
    
    @State private var themes = ThemeGame()
    
    @State private var addTheme = false
    @State private var editTheme = false
    
    @State private var indexTheme = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(themes.allTheme) { theme in
                        NavigationLink(value: theme) {
                            OneCellTheme(name: theme.name, emoji: theme.emojis, color: Color(RGBA: theme.color), number: theme.emojis.count)
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

struct EditTheme: View {

    @Binding var theme: Theme

    @FocusState private var nameFocus: Bool
    @Environment (\.dismiss) var dismiss
    
    @State private var emoji: String = ""
    @State private var alert = false
    @State var color: Color

    @State private var numberOfCard = 4
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Choose a name") {
                    TextField("Name", text: $theme.name)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()
                        .focused($nameFocus)

                }
                Section("Add an emoji and choose a theme color") {
                    TextField("Add emojis", text: $emoji)
                        .onChange(of: emoji, { oldValue, newValue in
                            theme.emojis = (newValue + theme.emojis)
                                .filter { $0.isEmoji }
                                .uniqued
                        })
                    removeEmoji
                    ColorPicker("Color", selection: $color, supportsOpacity: true)
                        .onChange(of: color) { oldValue, newValue in
                            theme.color = Theme.RGBA(color: newValue)
                        }
                    Stepper("Number of card: \(numberOfCard)", value: $numberOfCard, in: 4...theme.emojis.count)
                }
            }
            .onAppear {
                nameFocus = true
            }
            .navigationTitle("Add new theme")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Minimum of 4 emojis", isPresented: $alert) {
                Button("OK") {
                    alert.toggle()
                }
            }
        }
    }
    // MARK: Нельзя, чтобы эмодзи было меньше 4
    var removeEmoji: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emojis").font(.caption).foregroundColor(.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(theme.emojis.uniqued.map(String.init), id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            if theme.emojis.count > 4 {
                                withAnimation {
                                    theme.emojis.remove(emoji.first!)
                                }
                            } else {
                                alert.toggle()
                            }
                        }
                }
            }
            .font(Font.system(size: 40))
        }
    }
}
