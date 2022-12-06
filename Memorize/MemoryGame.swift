//
//  MemoryGame.swift
//  Memorize
//
//  Created by Benjamin Craig on 12/4/22.
// Model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    private var score: Int = 0
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent?) {
        cards = Array<Card>()
                
        for pairIndex in 0..<numberOfPairsOfCards {
            if let content: CardContent = createCardContent(pairIndex) {
                cards.append(Card(content: content, id: pairIndex*2))
                cards.append(Card(content: content, id: pairIndex*2+1))
            }
        }
        cards.shuffle()
    }
    
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
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices
                {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }

    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isSeen: Bool = false
        var content: CardContent
        var id: Int
    }
    
    func getScore() -> Int {
        return score
    }
}
