//
//  Font+Extension.swift
//  swiftui-wordsearch
//
//  Created by Jerome Bach on 18/05/2023.
//

import Foundation
import SwiftUI

extension Font {
    static var primaryTitle: Self {
        Font.system(size: 25, weight: .bold, design: .rounded)
    }
    
    static var primaryContent: Self {
        Font.system(size: 15, weight: .bold, design: .rounded)
    }
}
