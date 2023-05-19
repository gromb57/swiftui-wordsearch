//
//  LoadingState.swift
//  swiftui-wordsearch
//
//  Created by Jerome Bach on 19/05/2023.
//

import Foundation
import SwiftUI

class LoadingState: ObservableObject {
    @Published var isLoading: Bool = false
}
