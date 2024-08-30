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
}

extension Color {
    init(RGBA: Theme.RGBA) {
        self.init(red: RGBA.red, green: RGBA.green, blue: RGBA.blue, opacity: RGBA.alpha)
    }
}
