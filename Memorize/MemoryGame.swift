//
//  MemoryGame.swift
//  Memorize
//
//  Created by Benjamin Craig on 12/4/22.
// Model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {  // computed property
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    private var score: Int = 0
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatch = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatch].content {
                    cards[potentialMatch].isMatched = true
                    cards[chosenIndex].isMatched = true
                    score += 2
                } else {
                    if cards[potentialMatch].isSeen {
                        score -= 1;
                    } else {
                        cards[potentialMatch].isSeen = true
                    }
                    if cards[chosenIndex].isSeen {
                        score -= 1
                    } else {
                        cards[chosenIndex].isSeen = true
                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent?) {
        cards = []
                
        for pairIndex in 0..<numberOfPairsOfCards {
            if let content: CardContent = createCardContent(pairIndex) {
                cards.append(Card(content: content, id: pairIndex*2))
                cards.append(Card(content: content, id: pairIndex*2+1))
            }
        }
        cards.shuffle()
    }

    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var isSeen = false
        let content: CardContent
        let id: Int
    }
    
    func getScore() -> Int {
        return score
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
