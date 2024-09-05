//
//  Extension.swift
//  Memorize
//
//  Created by Матвей Глухов on 30.08.2024.
//

import Foundation
import SwiftUI

extension Character {
    var isEmoji: Bool {
        if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
            return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}

extension String {
    var uniqued: String {
        reduce(into: "") { sofar, element in
            if !sofar.contains(element) {
                sofar.append(element)
            }
        }
    }
    
    mutating func remove(_ emoji: Character) {
        removeAll(where: { $0 == emoji })
    }
}

extension Color {
    init(RGBA: Theme.RGBA) {
        self.init(red: RGBA.red, green: RGBA.green, blue: RGBA.blue, opacity: RGBA.alpha)
    }
}

extension Theme.RGBA {
    init(color: Color) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
