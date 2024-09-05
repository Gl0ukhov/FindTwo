//
//  AddTheme.swift
//  Memorize
//
//  Created by Матвей Глухов on 05.09.2024.
//

import SwiftUI

struct AddTheme: View {
    @Environment (\.dismiss) var dismiss
    @Bindable var theme: ThemeStore
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
                        theme.addNewTheme(name: name, color: Theme.RGBA(color: color), emojis: emoji, numberCard: emoji.count)
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
