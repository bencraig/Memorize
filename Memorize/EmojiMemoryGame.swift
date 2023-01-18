//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Benjamin Craig on 12/4/22.
// ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    // Type Function
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if pairIndex < theme.emojis.count {
                return theme.emojis[pairIndex]
            }
            else {
                return nil
            }
        }
    }
    
    private static func createDefaultTheme() -> Theme {
        Theme(id: 10000)
    }
        
    @Published private var gameModel : MemoryGame<String>
    @Published private var themeModel : Theme
    

    init (theme: Theme) {
        themeModel = theme
        gameModel = EmojiMemoryGame.createMemoryGame(theme:theme)
    }
    
    var cards: Array<Card> {
        return gameModel.cards
    }
    
    var dealt = Set<Int>()

    //MARK: - Intents
    func choose(_ card: Card) {
        gameModel.choose(card)
    }
    
    func shuffle() {
        gameModel.shuffle()
    }
    
    func newGame() {
        gameModel = EmojiMemoryGame.createMemoryGame(theme: themeModel)
    }
    
    func getTitle() -> String {
        themeModel.displayName
    }
    
    func getScore() -> String {
        "Score: \(gameModel.getScore())"
    }
    
    func getThemeColor() -> Color {
        return Color(rgbaColor: themeModel.color)
    }
}
