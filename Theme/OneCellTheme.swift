//
//  OneCellTheme.swift
//  Memorize
//
//  Created by Матвей Глухов on 05.09.2024.
//

import SwiftUI

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
