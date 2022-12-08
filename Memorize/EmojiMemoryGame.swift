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
        MemoryGame<String>(numberOfPairsOfCards: Int.random(in :5...20)) { pairIndex in
            if pairIndex < theme.emojis.count {
                return theme.emojis[pairIndex]
            }
            else {
                return nil
            }
        }
    }
    
    private static func createRandomTheme() -> Theme {
        Theme(name: Theme.Name.chooseRandom())
    }
        
    @Published private var gameModel = createMemoryGame(theme: createRandomTheme())
    @Published private var themeModel = createRandomTheme()
    
    init() {
        newGame()
    }
    
    var cards: Array<Card> {
        return gameModel.cards
    }
    
    //MARK: - Intents
    func choose(_ card: Card) {
        gameModel.choose(card)
    }
    
    func newGame() {
        themeModel = EmojiMemoryGame.createRandomTheme()
        gameModel = EmojiMemoryGame.createMemoryGame(theme: themeModel)
    }
    
    func getTitle() -> String {
        themeModel.name.rawValue
    }
    
    func getScore() -> String {
        "Score: \(gameModel.getScore())"
    }
    
    func getThemeColor() -> Color {
        switch themeModel.color
        {
        case "Red":
            return Color.red
        case "Blue":
            return Color.blue
        case "Green":
            return Color.green
        case "Yellow":
            return Color.yellow
        case "Orange":
            return Color.orange
        case "Purple":
            return Color.purple
        case "Cyan":
            return Color.cyan
        case "Pink":
            return Color.pink
        case "Teal":
            return Color.teal
        case "Indigo":
            return Color.indigo
        case "Brown":
            return Color.brown
        case "Black":
            return Color.black
        case "Mint":
            return Color.mint
        default:
            return Color.gray
        }
    }
}
