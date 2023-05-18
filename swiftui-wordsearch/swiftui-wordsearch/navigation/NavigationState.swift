//
//  NavigationState.swift
//  swiftui-quiz-game
//
//  Created by Jerome Bach on 18/05/2023.
//

import SwiftUI

class NavigationState: ObservableObject {
    @Published var routes: [Routes] = []
}
