//
//  LoadingView.swift
//  swiftui-wordsearch
//
//  Created by Jerome Bach on 19/05/2023.
//

import Foundation
import SwiftUI

struct LoadingView<Content>: View where Content: View {
  
    @Binding var isLoading: Bool
    let content: Content
  
    init(isLoading: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isLoading = isLoading
        self.content = content()
    }
  
    var body: some View {
        if isLoading {
            ProgressView()
        } else {
            content
        }
    }
}

struct LoadingViewIsLoading_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: .constant(true)) {
            Text("Hi there :~)")
        }
        LoadingView(isLoading: .constant(false)) {
            Text("Hi there :~)")
        }
    }
}
