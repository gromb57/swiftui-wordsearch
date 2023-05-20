//
//  CardView.swift
//  swiftui-wordsearch
//
//  Created by Jerome Bach on 20/05/2023.
//

import Foundation
import SwiftUI

struct CardView<Content>: View where Content: View {
    var height: CGFloat = 200 // default height
    let content: Content
    
    init(height: CGFloat, @ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 2)
                .frame(height: height)
                .padding()
            content
        }
    }
}
