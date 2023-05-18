//
//  swiftui_wordsearchApp.swift
//  swiftui-wordsearch
//
//  Created by Jerome Bach on 18/05/2023.
//

import SwiftUI

@main
struct swiftui_wordsearchApp: App {
    @StateObject private var navigationState = NavigationState()
    
    var body: some Scene {
        WindowGroup {
            //NavigationView(path: $navigationState.routes) {
            NavigationView() {
                MenuView()
                    /*.navigationDestination(for: Routes.self) { route in
                        switch route {
                        case .mainNavigation(let routes):
                            MainRouter(routes: routes).configure()
                        }
                    }*/
            }
            .navigationViewStyle(.stack)
            .environmentObject(navigationState)
        }
    }
}
