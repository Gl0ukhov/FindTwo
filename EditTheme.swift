//
//  EditTheme.swift
//  Memorize
//
//  Created by Матвей Глухов on 05.09.2024.
//

import SwiftUI

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
                    Stepper("Number of card: \(theme.numberCard)", value: $theme.numberCard, in: 4...theme.emojis.count)
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
    var removeEmoji: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emojis").font(.caption).foregroundColor(.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 45))]) {
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
