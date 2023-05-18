//
//  CustomButtonStyle.swift
//  swiftui-wordsearch
//
//  Created by Jerome Bach on 18/05/2023.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat = 40
    
    @ViewBuilder
    var backgroundColor: some View {
        LinearGradient.backgroundGradient
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .padding(12)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .foregroundColor(configuration.isPressed ? .white.opacity(0.5) : .white)
            .shadow(radius: 10)
    }
}
