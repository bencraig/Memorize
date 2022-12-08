//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Benjamin Craig on 11/30/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
