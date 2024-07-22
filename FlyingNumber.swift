//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Матвей Глухов on 21.07.2024.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
