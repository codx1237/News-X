//
//  NewsXApp.swift
//  NewsX
//
//  Created by Fırat Ören on 25.09.2024.
//

import SwiftUI

@main
struct NewsXApp: App {
    @State var isPressed = false
    var body: some Scene {
        WindowGroup {
            if isPressed {
                MainView()
            } else {
                WelcomeView(isPressed: $isPressed)
                    .transition(.move(edge: .leading))
            }

        }
    }
}
