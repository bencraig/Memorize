//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Benjamin Craig on 12/4/22.
// ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    // Type Variable
    static let emojis = ["✈️", "🚙", "🚎", "🏎️", "🚜","🚐","🚒","🚁","🛸","🛻","🚛","🚑","🚘","🚖","🚔","🚕","🚗","🏍️","🚲","🚠","🚓"]
    
    // Type Function
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex] }
    }
        
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    //MARK: - Intents
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
