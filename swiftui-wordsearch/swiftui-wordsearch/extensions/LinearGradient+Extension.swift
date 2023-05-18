//
//  LinearGradient+Extension.swift
//  swiftui-wordsearch
//
//  Created by Jerome Bach on 18/05/2023.
//

import Foundation
import SwiftUI

extension LinearGradient {
    static var backgroundGradient: Self {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue, Color.indigo]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
