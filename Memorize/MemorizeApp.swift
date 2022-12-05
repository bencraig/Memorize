//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Benjamin Craig on 11/30/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    // EmojiMemoryGame, the ViewModel, is a Class - pointer is constant
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
